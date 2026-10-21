Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541699;
	b=d78J1KUnvR28wKicbwxDahxPZ6UermmQdnA0bTKtKpMPOC7vEHO4nCEpyjl+IVCfW8H6
	 oLv7Zv8Rnr9glP0ZJ2vOLTVBTh2ZikoESvzVgcIiYTeGG+Xa7HGaG8d6wXmToZ+IZJMB2
	 d5o+ZiocPTWem9lrf2OaHt0OOJKCSaaQPG9T+gpOFwkmePmAHPlhYZhI0TrDU7m1v2wB3
	 WoAFawbybAyK9UAAb98Cz9OcyQ7I5u7PPHeXReVY6z0R0tZl1DJBUEAtwlkM2dlHcDto8
	 W9IWuMyxZpl2MtLmpMZ+/N8yTnDQhnKQ0DaLaGyotZMCJAunJeNUKKyCIJA8NLWIlAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M1cEjrlJw0MSkHcvb3QCv5p5w10q47ufAh5GdxhFpGU=;
	b=iNP6ByxUPF6uQek3aHz/KnUksouSIibzRWl2YPZoCMxshjb+pzWnOF16uSix7pM9sqIR
	 LXzFSgaX0fZ7HpdNZ0tVrP5vOgJM/ItroIKQKAbQ6Gs7wKmGG8HLTenub1fiZc8pRQvGs
	 fCDQE6bShcJSp8aRXa6df4+OygIJEcjJNvTSr6OoPJIqFAXULSy+pTp9QWTaVubrG4jOJ
	 MsUpBQSlDUMPzMzAKDMVkz1EH4vjNqNp2/kGQpMyzlhpeAM6CfeA/Gb2N5JBEZQI+8vm3
	 2AiihlR5LqEPH+veluGJva5DgSpjnpmWdRzIYBWKN4nT2pCroW8+YNn/QDfuQKnTMvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="k8Ikil/5";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2FD606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E2FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=k8Ikil/5
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35c76e9614aso261812eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1792541698; x=1793146498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1cEjrlJw0MSkHcvb3QCv5p5w10q47ufAh5GdxhFpGU=;
        b=k8Ikil/5Jgb7VKMQ+rAg/QxB/rGMhUZoWgWh3gDVeP5Aj/L6hkSSibKuYsjwP/sNrB
         MljdvecICUMjVmSMpFV28sVTFLVS61m491NmhmXs6TzQiH5rAlgzatXyGo8Aggsd/Yk4
         jWjkWSG2iJvVagRd2Lileq4SbnMtPHQwAw4vz0DVV0LNFvuWoVerNSmLHcv5k8azGogx
         YOuS158BJvbVTFq/iRzLTFeWYp5vSVXVKKLZQlQr0mh1HNQPH0j2QNA3U7iRpvKmE6tu
         4E7R/sqalKkOnyALacE6Szz1fV1r7ddnFAkOT175B/0IpQXG70pUtuLQwHvszdRamSG7
         AsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541698; x=1793146498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M1cEjrlJw0MSkHcvb3QCv5p5w10q47ufAh5GdxhFpGU=;
        b=cNKSOS7QnQ5zJGOwn0zspEv0SiIVedSIt3FGSbjdgDc9PlZyNvOrs2fmTHdZQNXb+z
         zrnJkKoKJcEUie4OZj1jiNOulxM+e+QjfhQY7ML8d8tUDy0btdCZytogx2iAYOZNY6wV
         dw5KaMUcstIMsoCLj3S0W48VRJ7JpEKdG7ljLLBVsiOQi14rSgz9ZZNFCBtW9hxteKZX
         QfJb71aFe3/1hrTiSqJhN7evV5NwiHguMDbXUlcpmEg79DC9a1PRym+Z59RCB5I6w9XK
         fCYP8hc6+0hvNg3sI4YH5LXvddYmGjOisCNX0rrQgH1i3uInJfYr4XPjq027QgsmsLUM
         NlJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjwXiZB5aPXQnl8ZimV40WQrsn1jHhTo7XQdpzpsQxoFwjUjI5q8sPBUXs6PrgnHHKO/Y9MhM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVx//Hm4CcSzPFkzsR6OhsSzECFtPYz1vYEhi9BT1V9fabLuHt
	FIh/MD+8XkxgOe7ztxTL1gH3hBFqa9/KX9ac8GmF+J6VNvIkA/ZiAfvjpnFyj9lnNA==
X-Gm-Gg: AYBFou3090IRZaYxO5AY8WBN7DZux4omyYq46vukDblJ2CiWNUFraPyH6F2s8eUbmIe
	0tQbgIYbT3Z7+F+336bUOzw2K5BFZQeJQb1fqlKa28XjvVB7P2O4fQa7cVrK5kElRiaGSHjUJca
	uD6aNp1YKX/pKyR13Q/SEEnRu5dDMMOB0u1ev8gzlsCbL1NHws1pQBxkjkj6JDG6FEXs7jNznHS
	04vBmNVHnifSO0RWR3g56Fc7+abFkCEVyNxYtMwf1Fidg8Ugjzb8zVF2whnPB5YOfPNB2KsRtOW
	zQyA8BZRDNe5eMVgqEi7W4TSmUxpaXdD0gPXMgSOuyNAoKhNvaWv21GpOZgZJpee1aF7m/o+gPX
	PD5XNsk1cmzE38Y7VNnCLeWDR7V6dVzjpekeuXoOXu8zL9T6cJDsXZQGyGWgmEi52fzRa+lib3N
	etPATZHVEQ0v9GjOZdFNq6lotYXoc8D7L68RGPQeM4YGklGd3cY5uA5bpog3V1YJKs6PmXDpj8w
	lfch/9mqZqOgf86nROQc2SSozDz9SNYnOYD/DEjknbVVCSa4I7ToKwpVeloukc=
X-Received: by 2002:a05:7022:28f:b0:18d:5988:8d3 with SMTP id a92af1059eb24-190a109f74amr535990c88.3.1792541697865;
        Tue, 20 Oct 2026 17:14:57 -0700 (PDT)
Received: from cantal.lan ([58.136.73.153])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903aff3481sm1890657c88.10.2026.10.20.17.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:14:57 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	richardcochran@gmail.com,
	florian.fainelli@broadcom.com,
	opendmb@gmail.com,
	nb@tipi-net.de,
	theo.lebrun@bootlin.com,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	conor.dooley@microchip.com,
	bcm-kernel-feedback-list@broadcom.com,
	tglx@kernel.org,
	jstultz@google.com,
	sboyd@kernel.org,
	mlichvar@redhat.com,
	olteanv@gmail.com,
	h.feurstein@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/6] net: phy: broadcom: use timestamped MDIO writes in gettimex64
Date: Wed, 21 Oct 2026 07:14:49 +0700
Message-ID: <20261021001449.1306505-1-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179240607406.3135.6389434535700214639@kernel.org>
References: <20261018100257.566267-5-jjc@jclark.com> <179240607406.3135.6389434535700214639@kernel.org>
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

> [Severity: Medium]
>
> Does the calibration behind this value account for any latency in the
> PHY's external input capture path compared with the GPIO?

[ ... ]

> Suppose the PHY latches the PHC D ns after the true edge and the GPIO
> sees the edge G ns after. Then every interpolated capture time would be
> early by (D - G), and the true bound would be the measured one plus
> (D - G).

[ ... ]

> Is this input latency known or bounded? If not, would a larger margin
> be safer?

Let's suppose there is a delay D of some small number of nanoseconds
between the time the pulse occurs, Tp, and the time of capture, Tc. The
purpose of PTP_SYS_OFFSET_EXTENDED is to allow transfer of time between
the PHC and the system clock. The bounds it provides tell you the
accuracy of that transfer. In the case where the accuracy matters most,
the PHC is being disciplined using timestamps from a GNSS receiver's PPS
signal, which means the PHC time corresponds to Tc not Tp. So I would
argue calculating bounds w.r.t. Tc is the right thing to do, and the
350 ns figure is correct for that.

In any case, D is not practically observable. On the CM4/CM5 there is
only one pin, which can be either an input or an output pin. The packet
timestamps are not calibrated: path delay shows the uncorrected sum of
the ingress and egress latency is around 280 ns, and the only way to
calibrate the split into egress and ingress is to use PPS input or
output.

> [Severity: Medium]
>
> This isn't a bug introduced by this patch, but reg is a u16 that holds
> the int result of bcm_phy_read_exp() in this loop:

[ ... ]

> Can a negative MDIO error look like a completed capture here? -EIO
> truncated to u16 is 0xfffb, and that has INTC_FSYNC (BIT(0)) set.

[ ... ]

> [Severity: Medium]
>
> This is a pre-existing issue, but *ts is never written on the -ETIMEDOUT
> path. bcm_ptp_perout_work() ignores the return value and uses ts anyway:

[ ... ]

> If the INTC_FSYNC poll uses up all 10 iterations, wouldn't uninitialized
> stack data be written to the SYNOUT_TS registers?

I agree that both are bugs, but they are in the existing framesync code
and unrelated to this patch. The patch changes only the trigger write;
the polling loop and the perout path are unchanged, and as the commit
message says, it doesn't try to fix that code's error handling.

James
