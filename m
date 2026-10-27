Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110409;
	b=fdGFqkYaLBUYTVTWxq2E8YNo6xLdoXycsk5iUWytnp2R0Ca8Fj0+/TLZzXEYudQuPXSA
	 A9n+82DxXRprrC7SNm8sGHzFqGGzLl422Bn4lN1LE7QUfpdOFQifFYc+jcII5mzpFR7kA
	 NgLyaEaXCGBTIZg+U6DKUDRpY0RVu6MzPaQ3kfE8CUyEuAgOHAnynlGJ1aJMvv9kta+fT
	 q25cohaf9+9QJ21cMNG26qW7yGINxnQjvvZa6sv+v7UQYtTI59h67MkNK/cRLWvSQrFQO
	 0MiG7LyLQRdX7EBPOUFHivglSwJMwWUVYJFbBgT/iDoDbc1m01Vw2NbcRxIuarYXdVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+wwRE4YbCarjd+t1/fSj+jU2P5ILWdv4F0L1AcuDDxY=;
	b=OjOu/McBBlAxQNgGPsJvuQ+JOa/t7ny6i7oEvgMT8yUwICpy7eriniDw7fjMZr0yQ1zt
	 ADLGh2a4IH00ypzCw+H91dxCwIcFVRuEa8LOJn3QUJHsW7UP/2AXBQlF7FEyyM74vruU1
	 6YbBVd7rZqM9RCHc8b0mnOQKAUwvmaiep2b+59+UtbtQsViT0sN6IY45piXrjQiK+mRN+
	 uKIwtb96RGeprtUu5SsFEKS6bznddmKOapFfGsjZcfpx9f/j7+sLXmlGrdRKsxRTTsAQH
	 EmAx7X5NYDw4x/Zy4Gb47NYjLjayHunmAKhy8gC3kXoBE/hIM5WqIypfSew0fXccDfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E8MCkDc1;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B7606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E1B7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E8MCkDc1
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7bec5112765so2867457137.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793110408; x=1793715208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+wwRE4YbCarjd+t1/fSj+jU2P5ILWdv4F0L1AcuDDxY=;
        b=E8MCkDc1ZOB05QlNVhSuuMV94FpcyqanROVNX6tw3aiHC1GRKBP+u6orBEorRHpnhD
         WvIbVRkzzZfDjvgW1S2pSZzN2mNLhr3htH0iMAAv/qYmVWknGxeCM11YR8oXxf/Okeqs
         6n8D+82cMHT6ePyOTent1OIfewKWD+NKTgQ0vSf245e4mtyMODZ9zY4KmGfs3J4/a2Vc
         c74nPZtgiHvKTN/x2Pvrr+Fb3mJWL3aIPMfcF9eOeHIwqkoaM1PnZU20IKH08xLS6P5r
         +pmuvNh95XO7T5yBaSqZ1qTdhws6BPy1fsw+Xyy+AJMfyKpdLg9Kril+Mr7VlwB3O749
         HeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110408; x=1793715208;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wwRE4YbCarjd+t1/fSj+jU2P5ILWdv4F0L1AcuDDxY=;
        b=g7uH8G+B+EJH1D1B41vpjd7UHaPnY1Aby8YyZ3pXh6Dn1D9eJJmxSi32nXkr3t9fhi
         Wuui0roE4kNMg3lnbHjnzjuJluthu/C/mxGUUNwpRR1YYnA4mOHj0wH9ux94dYnGidlX
         ypvEb3WMCo/aVd36bch+5z9m4+HegfIbwLiMCi3xQjQlvuEDqsmkoDiJ2f2wNTGNvhkp
         6wiVsK+hIbiyczHevVhyTcvt18VKr8tjgSf0jyHWZw5L1Z66onPnCVeYJfBa8g8w+bjX
         H2+hYq1sClALQrEooYGyixf27hh8s4E4Vr+evA5VPeEi3J9LvU3b8KFdFyX1+zeomDnQ
         gKfQ==
X-Gm-Message-State: AFq9FYIsbBv3u03iqKnY5B7uF/a70OfzIMKby/kPyleunZWvFqexi5pv
	MwnLdWnguAJK9ZqDqBdNUkvF5Bpgu1oR8ZcE+AGSoIsZTDzOECDfDhq+
X-Gm-Gg: AYBFou0rHbnRA7iVN2307i4PjGdpQgxBi/GCm0MN56NlAF0gOkW+ue0fSILYv+I7bHg
	b/HeI8PHc3YHdhm5nY2A0nTIRwqitSEzORDXO8LYBbH0BqVTjMflwRRFFhNRkfyWzOsX+So1l2O
	9HctwL4/uOSLl7RD8ciTSurtZk+VGKl3o/nSebzEBRPFtyi3G4dZtKS/rMQPPvIZMI0rIBmmFnM
	IU3ywWCp1Ilj7GOYRwdgy26n/iXjSQCmXQx2Bj0a7ThqvUiRv8jPz38Kuj5jWca86ATS1kHuDZI
	2UL4qS7TevEIHcZNQjjcnIAWO4DDcgrzW3K6rfuc/h7cvkZmEyAVjkBbCYAYCuCDbIwY0YcuBvl
	cGqpb/iJO4Xjfud/M7ghLfsrZ97UbIgrZM8ENq4EPKcgjr6Nfd0vZWz8FSWybJAC7EaoNRWTkRt
	zKeD5b5WEuYtZ5SPco72ZBqtEF+8BH7Kwew0jQMi5SynvXQypTEPNLiIqPqV1FTom1URJKR2NPC
	KDqesxb0UsT258Q9n7f2XnsOiQ2PLY3mmIKHoHTP9jVOmoYRJkr+lTldhKZbp2x90/vfqkf0unl
	v8ODJOIT6nngsB/PeSziM+ZXYYUOrUxplzIrxvLaFIba4WMlyF5L+gDyrfMgsZecaHBqcLsniV8
	TOgMjwijSNICMHG0RQwg=
X-Received: by 2002:a05:6102:3fa7:b0:7ba:9a61:23eb with SMTP id ada2fe7eead31-7ce5ce8051dmr3774201137.37.1793110408098;
        Tue, 27 Oct 2026 07:13:28 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3d32a48sm2573543137.9.2026.10.27.07.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:13:27 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:13:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xiao Liang <shaw.leon@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>
Cc: netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.979ea775ab87@gmail.com>
In-Reply-To: <20261027101830.85327-1-shaw.leon@gmail.com>
References: <20261027101830.85327-1-shaw.leon@gmail.com>
Subject: Re: [PATCH net] tun: drop batched packets while the device is down
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xiao Liang wrote:
> tun_sendmsg() handles TUN_MSG_PTR batches from vhost-net by calling
> tun_xdp_one() instead of tun_get_user(). But this path does not check
> IFF_UP, allowing packets from a guest to be injected into the host
> receive path while the device is administratively down.
> 
> Check IFF_UP in tun_xdp_one() before running XDP or building an skb.
> Drop the packet when the device is down, matching tun_get_user().
> 
> Fixes: 043d222f93ab ("tuntap: accept an array of XDP buffs through sendmsg()")
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


