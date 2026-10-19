Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439787;
	b=vXJxQPN5/3u5WFr+4R8d5RD7dCGk3ZROVkApjR6++Ag8CwOyJnTeva4H+9BBd7jVl3Hk
	 S1kKER4jntWjuYacQoT6HeWr0PfFIMdz+LAq2Fzka311HdL1Oc9RH7gmvtknKHoc/X/Iu
	 GHIwy7ih7aHYCt0v6PtDsgK1J1nXv5BDRyPFCVT8wMmIVRIRt0fG8c0GbFYJvWEamXUCt
	 v0Xdfmzvvg7qTLJNjbIk3SeW57OOHXmJqQW0StrQliuyvVzmCco+Zzc0vSJCnzJQVPw1H
	 iFpj5e9x5HguKw/rDiJcop8MiPj+JsxhMx1Y++0QxsW+0N3NxQzouXzOhL2jV5VcaJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=/jsRliy91BFODbj93z9kV7xYbKl60fLDTuXOxvxJ32o=;
	b=zTvgNre4MPiPjb5TpMuooC19TAnieOEqIfwWoGdbPBl1rO7JCLoDHQiFUV3rYe4hsvro
	 xaN2/XO1Ze//OcrjD7enJndG2ki9qbpAr5xw69nvkT5z5dwmlicB/GsCb7PcgZ5S9HB5Z
	 B5tscm/9HL2Hc4gvyuDbkcihirROiPg0x1SVb69svgCUZ0f+9uIJVvhrJy/vv2TkX5KqH
	 9OIaK17+nED0K9tOv+aVWknPhyGgh7y7yxPym1P5YMQ/65iWYfn9t4xbrMiHbmaqgyNWB
	 NXpsLl3aFm0pwXm+ZeGu034+wGoeHJbzlMeuitbFdr/1gBpCv9w/IJv7LHoeYfTy+WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=RdeKNFxe;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D160A2614;
	Mon, 19 Oct 2026 19:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B5D160A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=RdeKNFxe
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 6654BE83AA3;
	Mon, 19 Oct 2026 21:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jsRliy91BFODbj93z9kV7xYbKl60fLDTuXOxvxJ32o=;
	b=RdeKNFxe7esz40o+CZVO1cdhrr+a2HnHKGD6bH+4Y4j4Fa9D/fbeZL5R/8SUf+A8dC2TpH
	Hpn3lqNx9pibVMHRiFIMOER5Z7b8HRZLrpaeDKxC7Fe0J9KlNsX0bVxBapFkUfT36s+96z
	nqdMjVQkob9f9AUlA3O2pV6JUdiIKfh/MWTXSyyJzo/t6kYBitx+vBelHWQz1klYv1kGkR
	MLYhU0mAW/ZdKOrgaKCHnF1fhEFNn0YmyPgXF7o5LCJ+vTdffuj4kBaj5V1JygMVQ2DZli
	FUNkPOhVC7/+mN343VUhTkyYEUmzo8mEr+lZtNr9ymOm3Zubd4GYbcqtXUrzXg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id LLh8fmBoGBhy; Mon, 19 Oct 2026 21:56:25 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:25 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org,
	o.rempel@pengutronix.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	piotr.kubik@adtran.com,
	saikrishnag@marvell.com,
	horms@kernel.org,
	kyle.swenson@est.tech,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 05/10] net: pse-pd: check the PI state under the lock when setting a power limit
Date: Mon, 19 Oct 2026 21:56:23 +0200
Message-ID: <20261019195623.308032-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <bb8eaf92-2b5b-46a1-b39d-a29ae273a3b5@bootlin.com>
References: <bb8eaf92-2b5b-46a1-b39d-a29ae273a3b5@bootlin.com>
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

On Mon, 19 Oct 2026 14:30:24 +0200, Kory Maincent wrote:
> I think you can ignore this sashiko point as for now.
[...]
> With the change ask by sashiko on the kdoc you can add my Reviewed-by tag.

Thanks, Kory. I will fix the kernel-doc and leave the race for now.

Carlo
