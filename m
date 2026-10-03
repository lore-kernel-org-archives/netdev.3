Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346713CF82
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033723; cv=none; b=YmaI6iHC2vbIAOZNwSVCAWXNoT/igjvVnO6Ufmi8C/IHtjHkhv9g+fIZfImaOwWLxCZSUfCGPh9BIZKcBxrE6/u9ecM4UtVr+etmN5FHY1VYp7lP1ARcvq1hJSmhoXt+LoH2wJwmXSqU3U2jTJ5EHOInDXDExvIKGDYjjFitRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033723; c=relaxed/simple;
	bh=S6IpNBcKmL3PhSWcpf4N/fI3jBT4wveem4uoeaU0MHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVn7LX66iNhoF2K5kjiCYOgKeV/BBG+UX3BUYIxRPisqr48SQnS0IInRMeFvgIx+VanQZwK9vGUP3VRIvhilexLPXHaeRF1/VEG+p+1KKrSDG9XOXk8gfHYTn3N26OJXV0hRu7SYqv6Bx5x86SWsCo6vJT4DONWw+lRDJ6uoL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U43FuAKq; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U43FuAKq"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3d90ac37so246280e87.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791033720; x=1791638520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CKBoRMRFEoo0hLGBdRJZ8j/cK4OAfKROIAh0HFjgvuQ=;
        b=U43FuAKqEICQGXBmqTl5vPkJjfVP+mseenjwCILcaBwUxDsO4uQIEFR70aVkQEpAKe
         LFQggIEmDlmi6gu7fT/P0I4pEiINsA/nQPgwRsts2L/fJt311A1owjOvxTog6QuA05Oy
         GYtgIzN981x9UgOQLGSGokOe3iptHonA9GvuvRO3Jv1luUAq47Pe3V4e8Buukc8h+KpH
         BK93GnpFgxKOITKQ6ZTQk4EBiGPmdDC3d8Iq0jZGVYSGY+3nLTWZxQF2XHZE4VGT4wIA
         gIoBGUsOJQYuhLIxHHSdHbr8mOmw0XRhBLIk+klOAunywqamjeRAbQyiXkqXzGs2jSQF
         zS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791033720; x=1791638520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CKBoRMRFEoo0hLGBdRJZ8j/cK4OAfKROIAh0HFjgvuQ=;
        b=tvyLqCViQ9rxWpsOM2WfJc2zicJfr9qmL9HYpYbxcn7T/Jz6+G6NfmvehHjF2CwzHO
         oJHX8pcigpVJxaiAw5NA62HIdDVDSZzZv4uBklWpnF/hREwA0foduAChh/UAK8DH6xPr
         VuSuEWL+InvDtlGn8oumnZol1x4ZQk4Ec9zIqp5cx1jfZk1whjbnUFDBYQ3a9xGbMvn9
         Jmstcp9oIiSL3gOJiaGYxcrdGbYltg21d7RU0JsjzB2KiopG47s3o4rlTvy/CkYyxDey
         PML38fa/LQAHYGsB7ZvEqfYFs3qdIl9wtBlHNh4wbU5ttg9ItO0b4A2VW/nX4K8rQLqb
         mUrg==
X-Gm-Message-State: AFq9FYJ3GfvQjGM+F28ynk2falAlHxCyEyoNDpCifS1a5HKZ1eFKSZje
	KAEITAiPfFLpa8X7az8DaB1iWcmLxlez+tygqErv5VAt3gaHcXqymQUL
X-Gm-Gg: AYBFou2F3WOvLlx0KnXzC7/Bfyuz3f5qVQ39HRLVIxi9V+yiElC01gH3b+kIdKE3hOV
	AB/5nWyh1Nsk3OH3s4TlBvehISYLiAWfjFjJaDv67jIX6I2JLXizeBJy3Pl6zLdTcRUCVmRlhZY
	aKdpz91hpLcQLRcVhwM13TuN7M5v7rGjMGWPu+LmtLGPqggachZpljbTFzFhZKget+Wm9JlQ/xW
	c4oWJ4dqFi3SdC4uZEfq6ll9YFh6V71m3wEzaUMyMk+Cuu3CijrQZR+kUMR1v0JHVAweIcVRmhv
	chhBb64QMBuIgo7q4oQHL6vJRbTyegiFfJYsC3TOhm3psYiFErhvdMgon01Wa/wEeWPxFr3e3XM
	kMUK1+I40EcifABbHEMUhK0HZYpxuqQ79UVf6IlGlRMmH4yFZ1/Mpb5md06DTlHEOi5q+GexW2n
	feX6H4c7FnHsKNUNPHJGjJHIiyoeH8G12LgC/H41aoYjYz4IFIUbGMwqR2txPBwkiH0IwCrBlHI
	BX3E8oBde0q6gxNMbosqnuvx2MxYRmarH6nbsc9EJdQ+eIuZZAY
X-Received: by 2002:ac2:52af:0:b0:5b8:eca8:c9bc with SMTP id 2adb3069b0e04-5bb9bc66ff3mr1541341e87.64.1791033719593;
        Sat, 03 Oct 2026 06:21:59 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c7bb704sm1595837e87.79.2026.10.03.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 06:21:58 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tun: use pskb_may_pull_reason() and remove SKB_DROP_REASON_HDR_TRUNC
Date: Sat,  3 Oct 2026 16:21:52 +0300
Message-ID: <20261003132155.4174966-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.3b99b3605b4c1@gmail.com>
References: <20261001093925.3529772-1-littlesmilingcloud@gmail.com> <willemdebruijn.kernel.3b99b3605b4c1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 01, 2026 at 03:00:37PM -0400, Willem de Bruijn wrote:
> Anton Danilov wrote:
> >  	case IFF_TAP:
> > -		if (!pskb_may_pull(skb, ETH_HLEN)) {
> > +		drop_reason = pskb_may_pull_reason(skb, ETH_HLEN);
>
> Should we update the skb_may_pull in the above IFF_TUN similarly?

I left it out because that pull never used HDR_TRUNC, so converting it
is a separate change: its drop is reported as NOT_SPECIFIED today, and
with pskb_may_pull_reason() it becomes PKT_TOO_SMALL.

I will convert it in v2.


