Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F8431E5F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781931; cv=pass; b=JWimjB3cDL3v+pKBuNoiEEyoDmBxDX4r3blSej/I372N2bZlXcPIpKtKqHcmsTe8H9NHyD7RjHJG/rlPvWLVkkedFxS5tFLLapYTvJRmeBahChUY/stXlWB6/UsvnwuTmkYtwrqBm3rU0lKipm90FfTsjUFoZwZ9ft0Yr0fA6yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781931; c=relaxed/simple;
	bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAoYdclOsaJsDNKBmxLEypihg2siktGLOZTjOoAtCiC8yyeAoGCug3qlGFKMrpwKodMZKofjXbwplY55e3q48JDJk3A5AizMpGoCDX8INnpUvZ99PLnd4+7XATt0gLnmPnJ22IUYi07J367ot3oPwjWUdtUEkjIJRctfwEq7mXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QD6ij8es; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QD6ij8es"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacef7d299so19975ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785781929; cv=none;
        d=google.com; s=arc-20260327;
        b=Tb1yl5MPiCNoc8wQQIQSM10dvThZYTXHWTIj7FjtJvdflp7JxCBXiOP/xRiMGLJX/m
         /SN7UFRBm7iXKXD6Uy9q7Jbr87D5M/M+mfMKuLKDXIG8feGssK7c4fR6looAw6DyDCQZ
         CDH2oxT7OvpmMSeE1vqg6bEzqO5DHWSHwE45rZXBg8fjP7zg9+80TOsOfchiB3xMwabL
         eRbkFnmowTp01FiArERH2FNrPiREastb1iuemWGCe6SlAqSb4mSuPTvKD/xC/ZC2s6AO
         IQwFtEk/2XVEJbH4uj6wHuXAdxUVRb8UjtdyuxrQ0/P4brBNbmwLK2nYzHWAd6UcTzxg
         L0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
        fh=WexEU67wI5uxz4M0fOZ7GvKlLPCh0MbylXrNRwb1nlY=;
        b=Msto+Nkx2Q9rh4PnFueRZCsNE2IjHQFIRgUhzfawh81Lr62MZBeTlvOXcqOhmJjBbv
         NwmQsl1nKwQLSvmWvv2OGuJ5/8o5JGY7ki6qQI/+wAWvs+cmP28mSc4M9xx5eusancvr
         4jDVOOr4OuK4xi2ZCTsvCKGPhHf5BJ/vGb9dKgiP2xgIUYQ0hzoa6A1paHdBb1qgsAmE
         0memcSCcVfc6PN0Ju0uOX/PHYhChhtMfaUjyo1Nhpao0/Y3GJmJrQds/XFNXsR2RD+jL
         riSMhqq7hNjFuPi7wlUAFSRIFICQSAZ+9K/P/wDCpFAnHD/zXu+vxIE3PIR8qCYUKgsK
         oGBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785781929; x=1786386729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
        b=QD6ij8esOYUdm2Uo++y+AEpUjnjjH0LBBYwmfY+bS9fhjaa2Jz6yMUdQJ6rdyiwJJR
         Zpz6Ccu0E2qvoLIpHHRrJbUpvsUgTTyibW1YsdH8XtzWuNkma/PviKEf0T0Yat+QTnB7
         8gq0Rwl42AoT1/z212tY8xY5VqAEHBNvDvaTAke2qiNRpZLr5iHz9XkOS6DSdyt5ae74
         LI158rARYwKARIaxOCcK4NC3AfJoq6grQFB43hawuf8s+05uQn0jI67WEe6++/G5FC/v
         g6S6JrG2Zxe5lWJMOro7sp7lK1yaAvlNbcJ3iRN7EJDv9iE99pweW6M+vXQU2Oo1Ydgo
         Dr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785781929; x=1786386729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
        b=iD3oKIlQF8ZYuEdj+MaNub/+C/Eo6o5Xnf03c+OVvv5O6MYKzyEPiNVSN4YvBsT3rP
         4ixQhLY68q88NqejKaP/uubc7Nb+BtKLuB4V3A2JcYgDbqygoNB0ztGrwxMJxdNs4wCn
         u0eqDgTbV/plwxRDPTKhwAfQVD9soinKtRM5jhGVuHl8RC67xrZHor+2/WOpUziHzPXR
         P6XIBxm7iOAuuu86z4dCr9aUul0rbAL3AUoicFKoM61TrXZZWPwpbm8hdQIjm1hKt4Y5
         vOloW+N/pr9JBmx+ZkI2cCNZyZ8WV1GVdebxLyiNHD12Kg3B5K6kSPK6O176pBpex9e8
         Gxcw==
X-Forwarded-Encrypted: i=1; AHgh+RoYtoRa0s2mnNXcGy5R1VDTC8q9qVrV6C/AuWETB/JfT0tX7p413bhxx8/U6UJON4aXwA8Kga4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5K9eAZmQ6jjSYp+11vELqjXwQI6gdV1uHv9mh75u2Kn0qEL6N
	4KKg98mxfPlrJgqriQAZWShtvqRcYIXmfNHpDteiFqxc9M9NkB5OmKHNnH8t9iSV55OeTs1OJmO
	6jcm+682coIIZJuLINDmiTJqjniPcmvpDhxqhm//J
X-Gm-Gg: AR+sD10w1SFzZpPnzJOUMS/JW2uxZG5bj3V5w3cLHIpf9p9Ohp64JQdMBF2oMk2I/Bs
	HbCCz8t9uSwKg4SjDS7UR9maKMxkxFscmX4u/QMkmKQK/Q0nTR4FOyTz2ZawFeU9K0N74y2PxF7
	DYtx027ycYs9qYUxjO8RgNLvU5YSqu1Ih+nKbMjapLLr1ruoqZCGaM4xjUjMw6s5jKzcaZkyp9U
	QPa+E8sOteUT7NSKEpgH4ITVBcn+FU87jfNQDS0HoHsj8t7EffYKPPMwfn7sFYIjgKEUu+smNES
	Usr5I+E1bV97GoDMxEDoZhFP0DLPfH2nGLVVnMCWWMQ9
X-Received: by 2002:a17:902:e945:b0:2d0:8b22:7eaa with SMTP id
 d9443c01a7336-2d08cb31baamr1688045ad.20.1785781928753; Mon, 03 Aug 2026
 11:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com> <tencent_EEDC35FAF2750A3A6A0B39BAE0E2C484860A@qq.com>
In-Reply-To: <tencent_EEDC35FAF2750A3A6A0B39BAE0E2C484860A@qq.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Aug 2026 11:31:56 -0700
X-Gm-Features: AUfX_my3dNHecsoUf8e69cV4C1hLKJkdXZo40JvErJWzFKOvN7k3ok7JtkXPFd4
Message-ID: <CAHS8izPdDV88eP90R2sVa_dLUy=btQWTHJ804g5TrDh_2xKKLw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: atlantic: free stranded TX buffers on ring deinit
To: Yangyu Chen <cyy@cyyself.name>
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Lino Sanfilippo <LinoSanfilippo@gmx.de>, Igor Russkikh <irusskikh@marvell.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:46=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
> call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
> stops at hw_head, which no longer moves once aq_vec_stop() has stopped
> the hardware and NAPI. Completed descriptors beyond the budget and
> everything still posted in [hw_head, sw_tail) keep their skb or
> xdp_frame when the interface goes down: aq_vec_ring_free() then frees
> the buffer ring and the references are lost for good.
>
> Today this is a silent memory leak on every interface down under
> TX/XDP_TX load. With the conversion of the RX path to page_pool posted
> for net-next it becomes much more visible: XDP_TX frames carry fragment
> references on the RX ring's page_pool, so a single stranded frame keeps
> the pool's inflight count above zero forever. page_pool_destroy() then
> never completes, the pool is leaked together with its pages, and
> "page_pool_release_retry() stalled pool shutdown" is warned every 60
> seconds from that point on, on every ifdown, XDP detach or ring resize
> under XDP_TX load.
>
> Bring back aq_ring_tx_deinit() as it was before the removal and use it
> for teardown again, with one extension: TX rings can hold xdp_frames
> nowadays, so release those too. They are returned with
> xdp_return_frame() since this runs in process context.
>
> Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
> Cc: stable@vger.kernel.org # v4.11+
> Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

FWIW,

Acked-by: Mina Almasry <almasrymina@google.com>

I've noticed these claude-generated commit messages are unusually
large compared to the human written ones. In the future try reviewing
the commit msg manually and making sure the amount of detail makes
sense.

You can put extra details under the `---`

--=20
Thanks,
Mina
