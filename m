Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004450;
	b=cN61ftazzIq8NaBEBkXaLOWK8j6dalAFdZNI1eWbNQyeb5kKELEgci/C7ZN5RhOljE0T
	 kMITaPdgSR7n2exnxPq71Pj/yQAmkGvxlAUFvChK6SHmgPVRKmjRZJlil5X2Y7KY8a/nt
	 KI1jRIvh//4i1Y5whIInLClwnV2UsnWbXpY39Qrk1O69jKGezNxhvhiveHKMZ+kRLxMuq
	 YPJhV5CSVx7LPDEi+o/F8+Oge3KAoaq932q1fGN0FacZ32z4hPZgyk6l1ZViWWrot7WwL
	 ejkpkqhJUu4iHbWinTiQxUk9/qSkdluf1/W4yajtkdnhPrc0vpiK5lMfmCO4sA+Us5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7wd2nDG259Sg9DGdLfxO/C9vsE1qIzdNr5RuSIYx/oU=;
	b=0Yfn33q77rcuyzmmd3HnCKFALkpSt/8stXJRTwci2MLVQrXp0UZr4I42knS95cH6uFBz
	 CdSel2kERtH1lTr2IIircQLMKnzgfptaqx3rpLRMDNL3SkLrl+Bnu1Ksdeqrt6FVFtBil
	 v7cLsonwE/cuiMc/T0hwDFRoGpuKg/c0oeOqKtv40oU1gm5f9s/wwIkGRHdl44AQiri8I
	 imDliJAKhJKanxkv2E7z3YRPoKtVjEGm/gc/PwvXW5mQQyZD4k0r5djtOSQxaqjII2NG3
	 2oxDBOJZxxGZQa3Tu/otyvZTKCY7HbDasMyVw5u/ruhoEoIpsxLSw7V1Sr5k2iBhftA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Ahg9c9Da;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A0606A320
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 412A0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Ahg9c9Da
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b125371596so26289387b3.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 01:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793004449; x=1793609249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wd2nDG259Sg9DGdLfxO/C9vsE1qIzdNr5RuSIYx/oU=;
        b=Ahg9c9DaKmVBdNalJ4sb4KnqqVOT4m5Hn6F3E+PE6gEKZGfTnjadnHip5UXH0Q54Ta
         D/AhhDjEpb8dFboZycf671R8shkp4QtYKXhHatn8ibSUmfTdMiQhb35WJZoIxwMrc/ga
         77oxlPrMkq76e3ms+ErJkITOLBbggvLoCpz2DFslTIEARMvRrT4qFdX4qkf0fPVxuUW5
         eqaCC0yMGi1O2NSeoRnKUlFm8XCn/NzeEXb71NNSG7xRx4ykF0mo6Pbs22J1KOe0drJF
         JOVhZhaZOhOmFjtKv9eHKJrgtD7l5R3cD+EiqYHOPlpKz+yd7erCk7k+bbpbZwES1Qwt
         dG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793004449; x=1793609249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wd2nDG259Sg9DGdLfxO/C9vsE1qIzdNr5RuSIYx/oU=;
        b=P0DG5fPb5ITKG0/YHWuurR+XtHCrpFkk7op1mDk6IZE2XeIpFLa7ujnLVdrA5s5Nta
         U9yJAE9eeSkYsYVBIC8SFjbSr2P8gqhFWRnPnamtR4zIw6jM8Pnw1llOWCrvGV5HV66N
         b6zRXtjw8bRXuM9HNvcJa1fCV83IdGiFb5OQ3lJ86cB//bvIQVR9qJbxulMEFl6z1gvk
         1Pd/99C/iu7bam/rigWReRuGMbBtVxt6Z9Fw2jwMlKZ4KH8DMAx66ua2hc20IAEhdpdW
         fHie/SoPIoKBuvQLdbDrZZg04bh72DhqXSMsRspCqJk8+rxfhcIo/SqD1LCcB6hz/Kqp
         V3uw==
X-Gm-Message-State: AFq9FYL4lMUWvtKRYI95o94PVryufOpTjky/EkWWPmJ0l/wJ/hkU+smO
	uQR5JnqzzLS2ODw5n0gLt2Liv/Dh/X3DpJqS+xSgAUyKd361VM7/sjFGMbXzq723qNsDPLT/fZl
	LJPAOrWQRhBE/14M93VVvOC8ry9tzt+aiFzDX9XeL4k7F0UcRAZhUdmPlUbGY3EG5of1VTl88hs
	37oXDXLqltfpuLjubu9GUPHnApPXQakdV3UUVVTFGf
X-Gm-Gg: AYBFou3ff47EyIMEoDzFmqjswRUtxLi8m3kj+ZPVHVTK6qayVVb45Nu0quWwXd2TXNf
	QrtNDqZN8S0uCHqC5xHD3j1iFKVFD1gMhl+fqvl0XeI3bGMFz113c9YYwFPn6fFotDcYmd9xHQj
	Ef/Av6EudPOHoAMT7YILmI8dW8Mz/Iz2Goev/E3f9FXsxDR4oTiULo25a4se1ET8sKWzQfFGS0N
	2AIHSzAFmlYqzFb2KY7bPgWTwxn+NsarPrRJ7ajejvCubK58CaTgTzzW2sSXrKAlnOdec/bAG6E
	t2RFIraTz1KQ1PXG5CoDvC1HwZRAQBpAroAx99B9VviUUTZMGBY4bN5xyYc3C6Z7v9RfuVuEe6K
	ixAZD7c9yOBxhsO5EtuEhAsF/ikEA195okg+XaoIU+P0nRq4aYf7SES4vLAR/gU12XUtsvfYrqy
	wpYSJDN87Z04nC0ehFMDf6kFUiiePCZdoBdPNYOWPhQ/9McSiytpQgW9mBp76f94/IhzzOPwHgq
	qI8Pln7WsYdqMM2dLxfg5RPulR3+w6KW21j0hnSOHOBRDj4aL7LYAeGuNguznk7EhzB3BoBAoVP
	3zPuBJrC2SW7p3jhUvasm2M=
X-Received: by 2002:a05:690c:c4e9:b0:8b1:368b:3935 with SMTP id 00721157ae682-8b1671e0c5bmr43816057b3.10.1793004449060;
        Mon, 26 Oct 2026 01:47:29 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166eb16d0sm28482337b3.39.2026.10.26.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:47:28 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jchapman@katalix.com,
	tparkin@katalix.com,
	gnault@redhat.com
Subject: Re: [PATCH net] l2tp: only return sessions of the given tunnel in l2tp_session_get()
Date: Mon, 26 Oct 2026 04:47:16 -0400
Message-ID: <20261026084716.2884624-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179294048471.3327.7148108321076866901@kernel.org>
References: <179294048471.3327.7148108321076866901@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I found this while comparing the behaviour of different kernel versions:
connect() on a PPPoL2TP socket for a second L2TPv3 tunnel succeeds on
v6.8 but fails with EEXIST on v6.18. I then bisected it to the IDR
session lookup series (5f77c18ea556, d18d3f0a24fc) and checked the
"ip l2tp" commands in the commit message by hand on both sides.

Thanks,
Hengyu
