Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36B83AE6FA
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605890; cv=none; b=Nd//7JjGuMBUpyZMW96Oyx4EJAwTO53L5KCg576kPDmldKoxN//wEgw4yGl0xUQ9ce7v2C+vQZLKUW5/iywzSgmFT7CPi7muGsd7D+Hz0F5K37tJsdemk1YXVp+2HGA6dL3M9w7wEMqblzvAUa0tHbEGR0J8EYSHYZbClCA0nus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605890; c=relaxed/simple;
	bh=ttRLp5uZBBXIDZVrjCp1/B/OT2B3HDt+3d9o6TVjSxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TG233MsHmsVuy7W1Zr/a9UAt/vYasJZDn6fJqS3fC2IESe7hv35w1cxVAX/VJVcwz5OuAyiEHwWGrGoRoBS/o7//lVT3uh2XQy7pK52jJaiWCvD6elX2YSuzSaaPpE79LiDGyT1pd9vEHMOqKoIcw1u7AHnJ3BYwdxIk4yRK8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=cCvfrCMW; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="cCvfrCMW"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-145047ad220so906858c88.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790605881; x=1791210681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XjEI2w0L+wVlxSuDV0P7eMrDPKELPiH3pO+YDTZIuR4=;
        b=cCvfrCMWtzK/r95NE2TdZLDL9vVOGEUnR0e/8U5i4KeiN9qic5XMPyQA2oZrDwELoo
         jdScsgI90nEkv8qdf4BP4GSojsHdp1HR282ON1+rHX5hI9F9Qfye0w3tpIRexndB74g8
         wjh0aDhHc9tyMmeOHrX/+Y7igxtEB35viPE+KQ1feQNi+6Xnshrdf4Wy5EUt9my17H1+
         q9BPGCcIMP3G2w06R/na71/tHnXysv1lvwf7b00k/htmjGXXPl/1AimDafAgUw7bR9Q7
         Cf+G+zVY5Q5ltsBzaqhDga6swiqa7DohJEjbBE8/TYWxjPP5MDt9mLF14YI8awWygDhX
         dxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605881; x=1791210681;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XjEI2w0L+wVlxSuDV0P7eMrDPKELPiH3pO+YDTZIuR4=;
        b=jUIaYiif/skpxeE6hSlhxscWbtmMZKOFyaj6sn/eBPHjtHIjuuLNzOOFEmtk6Bdc6E
         d9YSmu3/bFrOqfL8SCK0jPlIqyJJ2O+4UJtBFaguRLG4V8R87C9KQKHjjegpPWME35eh
         fMWQaYVL8wHpXmydlzCg0/rXz0yksxp1S5j2+u/MmbeRTpEQXBzGAI3gBVPVyn5LCSoE
         6acZqSEe1L75LAOIHw1kMfUsn0KhKjPRIMl+tzDXCyUQLuO7dhOEYoRmv+nJ94eggljh
         3igH+ObOA08Hun006FAInVSu2JzchPbdwzeJ5Y7JwTVUHRur/EuGr0hlnX9veISUxhcd
         600Q==
X-Forwarded-Encrypted: i=1; AKwUvBxDqC7aYXujfxFFEwZTuI7zkp7oOwcBkaz1SgmGrEzRO4Ur1VozUF+NuLe1KNWEdvPTeJ4U9WM=@vger.kernel.org
X-Gm-Message-State: AFuF++m/LbSPm4E4QYc9DdBvua7KZ74fyJMhDUi3lblaM67VnKY8DuzN
	BQh2lhoRgHwn/Hgw6V0Ni05JY3oVF+DJpSrBsi7J0DeiBIMH3XKdSy2kT7ieD7RsW7sMA7z+2kp
	WTBqgfPc=
X-Gm-Gg: AYBFou3rwNWG+ld3y+DCxj+jmfkd6adF6P7d02mjMhMMI5mpTXGfAktYeXw+nJNdKD/
	kXpJCfAO4IyOY8OnH2dQYd88XNSUk0gfaLVzkyrayUrnUoxjWq7M93MW6Jd9Txd/cwV1iTHA7zv
	WS9CjdPgifCo/iYqnKi80FEQWVS4yjGYWSDIlvlCoULj6sHmau+4MrC/zBabQ0+hNvF94QN+Xkq
	uyhW0vWUAcZIrIy/khPeWHerUgxr/RRzh9qpgWc6Aed18n7RFNC7a2nAec6iwA2g5i2+5OJylst
	6X96XEreuwq4fXuSfpwjriiRNtS7Mzst879smFgCOHDfXpoe+/OQAyPp6trDddkCBc08t5MX9LH
	AmAvr0R5wDHfjX8CSotv7HuoxxLI5++nVgDqPel2r4uQC2U6CpYZowexwXbDAddUJ/gDLlzwBlU
	r2eK/7DMBKuLjYphU/v6d7kvABWX/4Fyfeo5OULH39up6CskybBdAtGnV1UpVtXVo0Q55sPjAl9
	JFhFK+I27yxyTjhVTA6YMXmMjWAVgKaX1jb2LATri8LdgQkahwUiS2lCg==
X-Received: by 2002:a05:7022:6889:b0:141:517e:52ef with SMTP id a92af1059eb24-146ce492c9fmr13591875c88.17.1790605881108;
        Mon, 28 Sep 2026 07:31:21 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad9e097fsm28616577c88.13.2026.09.28.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, Junyuan Feng <a@lollipopkit.com>
Cc: dw@davidwei.uk, io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <010001a0cd914529-23df2f94-bbe0-49cd-ae5d-05922356fa12-000000@email.amazonses.com>
References: <010001a0cd914529-23df2f94-bbe0-49cd-ae5d-05922356fa12-000000@email.amazonses.com>
Subject: Re: [PATCH] io_uring/zcrx: requeue multishot receives stopped by a
 local resource
Message-Id: <179060587969.984285.7352315513863005103.b4-ty@b4>
Date: Mon, 28 Sep 2026 08:31:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 23 Sep 2026 09:20:44 +0000, Junyuan Feng wrote:
> A multishot RECV_ZC can go idle with unread TCP data when a receiver-local
> resource runs out. An empty copy-fallback niov freelist returns -ENOMEM;
> a full CQ returns -ENOSPC. After partial progress the stop reason is
> lost: io_zcrx_copy_chunk() and io_zcrx_recv_skb() report the copied
> bytes, and tcp_read_sock() drops an error from a later call once earlier
> data was consumed. The edge-triggered request is then not requeued, so
> it cannot consume the remaining data until another socket event arrives.
> 
> [...]

Applied, thanks!

[1/1] io_uring/zcrx: requeue multishot receives stopped by a local resource
      commit: 98ad5b63f5041dc354a6e694f4a9436f74e0681b

Best regards,
-- 
Jens Axboe



