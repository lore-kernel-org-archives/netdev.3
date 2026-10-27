Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103211;
	b=gWbMAzEB+U5u8cCIWKGbB9Z+FER2AvcmnOe7s7/vvSOYFpTaVvhIGuE3nLTizvQLk3aX
	 mwLAfjdn7upU2iv+xvIoNCksJ0fXA/P3f4alJT+bd8uNm3JQpeiuNqdp+ja2AhlE47iE0
	 LQp51aRbI1D26JM9S3BGvsGx8tk2BXDO7n7WFgKXzCxq6Vw/SbxUX7sFxvHC/iI/K7ggo
	 G+pB+mIVO+EP7rRM/KiiqePDWEYz/+TQubScTMrPBgJBLvFW77kzBVdPfquaZDhqaYJiC
	 f6lzuM7Ouw7uIyMNPOXYPTuW+lhPMEpRDoodXSmaxn57TMbOGU5EKzTuD+0roVWBNgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103211;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bv8zVoHbSrIX7BVSNh9Ga9PU7EhbCPSf8uQb+AR6ROc=;
	b=YRB5cxrxVUxBceKtk6RSo3nsEZ0+/XQUOaD4MA3/c5pod5+0+sZxxxDspmYkPg1jLSQN
	 JDJ0mfeIu3lzn6QLw5nPUac8eQg4WGKlHbqCyp+oT4MhwpiUmhRfgLRziH895VOt+8RFQ
	 4v0oCQWJqtyikOq/0OS51y7L8nHb8dV1pRVvgIaHFmTswsLa2wtJaJk7Jme2h22SC8hFT
	 5yow7mqH7OXnaqZIkn8SIpHCp0t+u4YjDuDAFKwToFkA2L4YUOn2IOhgxzjM6lVAaxnqg
	 WUFgDMDjpcBUguVkDKa/PYl5KtWGnK0rWFFefKgx1iejWPPrlJLyEB/AgHDrmIfhHdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jdtkfbrg;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=b4H3Zn2N;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D460A380B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A52D460A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jdtkfbrg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=b4H3Zn2N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793103209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bv8zVoHbSrIX7BVSNh9Ga9PU7EhbCPSf8uQb+AR6ROc=;
	b=JdtkfbrgCGLwl3Gty2ipvEKU9/LDKoP3Qw9jKYDCasCa0us0OBIBEePN1xStY3MHg5tztd
	u9qh8FRQIyUo4s8gt0Gmnp9bCT/gWp76ecNrBC9eRBtZ6/S2gQN2b50lO2F23SygVAF2si
	29bGuH94KYtDnQ2axKKXWDUoWFLy7kc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-QTRtp-xGNPyoSFdFXJAgXg-1; Tue, 27 Oct 2026 08:13:28 -0400
X-MC-Unique: QTRtp-xGNPyoSFdFXJAgXg-1
X-Mimecast-MFC-AGG-ID: QTRtp-xGNPyoSFdFXJAgXg_1793103207
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b0a199b20so3627485f8f.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 05:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793103207; x=1793708007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bv8zVoHbSrIX7BVSNh9Ga9PU7EhbCPSf8uQb+AR6ROc=;
        b=b4H3Zn2NqCXi1TzCWwVZtbcJLilvzGtuX5Ae7E2k3ErGVM7dOd+nMiBdMDSNFelp0C
         Wql16KwtnUVjx9H2ruY8ZlXpvxUYs0l8bl0gxQFymagtHBUCDym1JqBqWnaQiDCY3WFT
         FkNIdYM4xt7pRjVV0WXMU+jAagnw0TcyXXcagC6YcuZ7JHem48Mod9XT1XVGtr/3FtLc
         VQbqtc7WkXyjcTHf5hWQJZhEs9JuticAKj4uksVNVNpYVRFp+7Nq6AOQFxFN+XI2u17u
         S2WU0CxHDRnkRL9/vEPynUPnhwXDN+md9v3z5RTm/T3m0KtawYMK5ovBlL4H78fo5oWn
         MnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103207; x=1793708007;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bv8zVoHbSrIX7BVSNh9Ga9PU7EhbCPSf8uQb+AR6ROc=;
        b=CqaxzQzsVAn/7lCCyw28GEFhTVrs74PL+KxCzvN1vjT5+VByo0IpKlBGgW0+Sn4jRz
         qxWJmarQzr36cZ+asj8Yg4sqTqredoU51kJB9D2s2Xk8LjoLQw2cmY1nV8Y1xEl/znkB
         GnwKQ9uJJj36fkzfPJarz0Q8vm6oI+P1ro4fTSZR1Amvx26ALmPNCYCu8dLiL9P8rpbo
         LTan8urFSUawwgMj5ss1+dccOtXao3YF+rAadiMYKUcVVssbUTW7RI2kdNXazq1Hcp3Q
         13i2U2ZN1dajGEbqlv3XfwgW2mRK74LTPYBJRMr7XPwCm3BtvOgi/b8EyNYShithXNCk
         WdHg==
X-Forwarded-Encrypted: i=1; AKwUvBxZZQGtT66XJxNemrL/r+QUl9CsPeiRXVvyZeEsYH7v8QGTxN0U/SLdzv3zWf7cArohca+gzUU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfkMqqGGsKWrNYPTjs3iws0F11xt4DCfgbxyeq+J9VEBTxjGdq
	jcpOzvBX15GElxAxWpxhqU85WNW9NM2Sy0LzgycZIWimEPQcUZi7dBGCCi5F4qDWt7HoLTOp2pB
	PDoWMhJtup0uDYX6uyjUDDQbDe2AtgiERxm0ySkhEYp84RLkw5qYNM6Omaw==
X-Gm-Gg: AYBFou3DTvHdAMxPFLj6eH3AUivCYJ2kPfG6MIBzM30cvHlz5jr5wujrQUf6LPMyKHM
	GMyVFdH+ZFiqEkePvaLWaSXf6/RseRPA18ZD/eXOX+i0JUgRks5T1HgYv9/qYXLasrlrWzmkTgh
	HbVquZsZUS/3MnzOpADXetyoMt8n1ZcQScyv7dtOFuRQuVxnri3MGw9G6vJ+x5IfN5a5z9LC0Bd
	XuGJ+5c5JUXcKOF0LWpR/b5cyD4Ai+JkjQKjKexfJLewL104djAVJsr/8RMao7eOyVf6tDcVoGg
	tPOo1LAQXQbI5YnjBiDzAqAKS4p9o8QbaRIpFqL1j7ZkUe2Q/kNgsnI5sK18bZXsG6FkAOpD9gI
	oXYzlIN4sjFOPX+/+DapzcGaaDK6yeUuOqhbG7rNQhefTikAxTYCatP10xhlzMXT5XD5V1moPkQ
	==
X-Received: by 2002:a05:600c:3b93:b0:4a2:fe3:121b with SMTP id 5b1f17b1804b1-4a35acb0791mr198799815e9.28.1793103207046;
        Tue, 27 Oct 2026 05:13:27 -0700 (PDT)
X-Received: by 2002:a05:600c:3b93:b0:4a2:fe3:121b with SMTP id 5b1f17b1804b1-4a35acb0791mr198799275e9.28.1793103206632;
        Tue, 27 Oct 2026 05:13:26 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bae01sm324835885e9.7.2026.10.27.05.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 05:13:25 -0700 (PDT)
Message-ID: <8c000566-a792-4777-8148-6da137537f7c@redhat.com>
Date: Tue, 27 Oct 2026 13:13:24 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] gtp: Require 'CAP_NET_ADMIN' when joining the gtp
 multicast group
To: Anil Kaushik <anilkaushikwireless@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261023073738.2436362-1-anilkaushikwireless@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261023073738.2436362-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 09:37, Anil Kaushik wrote:
> The gtp generic netlink family sends notifications on its "gtp"
> multicast group when a PDP context is added or deleted, and for GTP-U
> echo responses. They carry the same attributes as a GETPDP reply: the
> MS and peer addresses, and the TEIDs, or the TID and the flow label.
> 
> GETPDP requires CAP_NET_ADMIN, but generic netlink lets any user join a
> multicast group by default, so an unprivileged user in the network
> namespace of the gtp device can read all of this. Found by code
> inspection.
> 
> Fix by marking the group with GENL_MCAST_CAP_NET_ADMIN, like the psample
> "packets" group. Only users with CAP_NET_ADMIN in the user namespace
> owning the network namespace can then join it.
> 
> This is still weaker than the check on GETPDP, which needs
> CAP_NET_ADMIN in the initial user namespace: in a network namespace
> owned by another user namespace, its root can join the group, but not
> use GETPDP. Genetlink has no multicast group flag for the initial user
> namespace, and ioam6 pairs its ops and its group the same way. This fix
> blocks the unprivileged users.
> 
> Tested by joining the group as root, as root without CAP_NET_ADMIN, and
> as an unprivileged user:
Please additionally update Documentation/netlink/specs/gtp.yaml accordingly.

/P

