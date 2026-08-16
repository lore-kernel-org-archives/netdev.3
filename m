Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEE11CA9
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838541; cv=none; b=Ep4wqT1nez0WA6gvbSxVdfHVJGNEo64O1dCMg6AoiwaBzLR9oqU6x4ig0pwOUvhP8GLUc6vu/40cMIgPnvg+P0WCgR6MZT1Op0fdrtBlR5P1qCf5oIXCJDNbRTJQVfnPgUMj8X0F/QhH0XQXs5OOwklVuC90rpq6asfKV0KDXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838541; c=relaxed/simple;
	bh=d8phVPdEHqp16VgqSLVJvjQs29buELJ4498RhK31tVE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pTIgTK0NZ+iMN+L35vTayROrb0bttNlT1+BAVJgJ1URn3/Op2cGpwa/RitNPRGbDdvZYWhz8l3fnQUDTNREFRQ6wyJuxX7zOqJwitAe4SkM9Dho6FEuuoD+JyNeASIWgMKcXLQxKaDfPnXWQEaULTqT6Dc+HU1lPHTEgXNmQE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=CbAKXYYo; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="CbAKXYYo"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-49c38a4f110so1374311b6e.1
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838538; x=1787443338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ogWrJClySs3xUgtcSiXTo+teNL0Cts1zb6TqI5m5YlU=;
        b=CbAKXYYorXb44hqvUgUr23yFex+EZW+PvNKzDgA0da9gk9Sh56QEI8tIYrNNV7ffZW
         cKOMGUsAJwMQJtrczQAkkfAGFr5H3RZ7VXEED8n6CzLX4TRIUHuF13MOS17PjVo+fWPl
         1qMb6xYzT6MzZzxF/MyaJbn1z35w93ilOVJ9rLOwq5TEXIU9XPT2wyo/X3Jemdj+7PI5
         s1x1fH3l+ozx6W7OBuIMKKdTF7+RVSQGsp0DCD5HDNZtZnGk7tQsVh9a0NSmbDgV8PbQ
         X/KqB7tYqW9YXikzBxxU4KZgCFKQzu9EfY3GBlBOdTYCdAeo/vLzAmF7QIq8h8vGDH9k
         lDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838538; x=1787443338;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ogWrJClySs3xUgtcSiXTo+teNL0Cts1zb6TqI5m5YlU=;
        b=O7u8MKbj1xi24f6vNZ8j9rGWMMFJy9b+rvaFXw9J8Xj6bhy7jNuY/A7Y9NbuTNc+ZU
         Z6hadfyrhuKuhxsaU/eLr5uew64RdrOxVF9+pQzR0cbP9wnnGPr49kFy+klyHs9L3NXz
         4eOjNZhisfSzMJgv+lu2WP6SOu1cdaNkJ41rf02Kb1Q3G2isX6XkweyCSI0mNj6COBFF
         2ubSZpFjLzdpuOSLqNlgglR0SlDY5vYoFhdLcOSu2yg59KzG0sfQEEXTj8g99gOUJd39
         VG86ae/B89GeJDn6Q3J2aNZ4PwtSNmRjtXxHP/JcTXGIVSDFFxucf6N0p+/eVHHbvs42
         i5fQ==
X-Gm-Message-State: AOJu0YztEGew+xokGWHb23AKwKi2MfeFATGjVXBbnvPueHNJXbJhDqKR
	OVgPF+5H705kCoFqsxmsVU1aFGZe9Mvru+G/aZdBmBj5cUJPsL0gKbFlO8b4WpV3HnUtTc+I7C9
	g9fmvLBTVXg==
X-Gm-Gg: AR+sD10xv9Mf/flyQzt1HkUPJh6pOxoqsZYsU1PcwZSBpCl0VrZqIP00M/tFAxCGYkS
	SIz4HqX3dB6C30yVTrAAlbz9Jm+42lt55xms2Qn+SJs6FwKmCuqSBTYGB+At2Fcz66hqWJVvrgX
	v9yRR54s85hBraFiBhNty7QMxlNax/MueZu7nyYCXk1t1Xzw0wkJhqPIiWVsW629pIFKhPmKdOG
	YuGVyHxkFhGlL052T28/hA6VC5U/ya801jAW/8nJgROg0lnuV8f6K4w69UfKXZG5BLaE3fzg/5I
	nzf2X4Qoqd2Yle6sNfbUxZEOGjPKrkrEjOzhyt7Xwmy983m4f5Ned5n533Dkv319WtWWB63lmGL
	omib0AAngW1z+ZnZK+xCM9S/RP4Eqgk0P5Acdm+hrWrJFBlsOPm6XKHLgnDe1hkHoLPWWaOzH/+
	TISnT3PXeLVlxo82tmQhGMmzFuJ3YbyBQfWB7pkKfYx4k7hdqZv6O9NtXuyCLWIp64zrnx+pSas
	vNqSHHSIl5EqApoo2WsJ4BgJ0zHVOq5k+oMSXcMpg==
X-Received: by 2002:a05:6808:3092:b0:4a0:d9a1:1a95 with SMTP id 5614622812f47-4b241cfd572mr15604177b6e.14.1786838538325;
        Sat, 15 Aug 2026 17:02:18 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:02:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <cover.1786108672.git.asml.silence@gmail.com>
References: <cover.1786108672.git.asml.silence@gmail.com>
Subject: Re: [PATCH io_uring 00/16] zcrx update for-7.3
Message-Id: <178683853475.1984298.4698280029125415324.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:02:14 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 07 Aug 2026 14:19:18 +0100, Pavel Begunkov wrote:
> zcrx update for 7.3. Patch 1 fixes RQ processing over-throttling,
> which shows up with larger page sizes. Patches 2-5 makes the RQ
> use more scalable for multi-CPU setups, including softirq running
> on a different CPU from CPU. Patches 9-16 implement dynamic area
> provisioning.
> 
> Pavel Begunkov (16):
>   io_uring/zcrx: scale refilling with large pages
>   io_uring/zcrx: move RQ head/tail to separate cache lines
>   io_uring/zcrx: add RQ iterator
>   io_uring/zcrx: cache RQ tail
>   io_uring/zcrx: coalesce same-niov RQEs on refill
>   io_uring/zcrx: constify area_reg on import
>   io_urint/zcrx: narrow var scope in io_zcrx_recv_skb()
>   io_uring/zcrx: don't reload skb_shinfo
>   io_uring/zcrx: add helper for deriving area token
>   io_uring/zcrx: don't pass ifq_reg to area creation
>   io_uring/zcrx: split dmabuf unmap and release
>   io_uring/zcrx: unmap under netdev lock
>   io_uring/zcrx: move freelist lock to struct zcrx
>   io_uring/zcrx: keep array of areas
>   io_uring/zcrx: lock area creation with pp_lock
>   io_uring/zcrx: add dynamic area provisioning
> 
> [...]

Applied, thanks!

[01/16] io_uring/zcrx: scale refilling with large pages
        commit: 1afcef59fea02c271f5bcf3496402c34b3508a0f
[02/16] io_uring/zcrx: move RQ head/tail to separate cache lines
        commit: 433c57e9b175ed82c0f68a58200d2f10a6ea5580
[03/16] io_uring/zcrx: add RQ iterator
        commit: 2292f4fbc54ed15b6ad07bf788a17903a3337730
[04/16] io_uring/zcrx: cache RQ tail
        commit: 888f7ab164508b4c7246dcb4475294d61b2db055
[05/16] io_uring/zcrx: coalesce same-niov RQEs on refill
        commit: 7b188cf990abe5e1f7bbc9d79db22ce1b414d7c3
[06/16] io_uring/zcrx: constify area_reg on import
        commit: ebb2b81a2d063675a09186a9dffd627ce50e5b9b
[07/16] io_urint/zcrx: narrow var scope in io_zcrx_recv_skb()
        commit: 7f32f17ffbcd2bd8157b9602e1e50b0129ef4522
[08/16] io_uring/zcrx: don't reload skb_shinfo
        commit: 2d837b9961ec7ce46d1f1241a88d2b1f57e87f5a
[09/16] io_uring/zcrx: add helper for deriving area token
        commit: 84a7fc9b1862dfe9e2e743ca6627d311a5e03545
[10/16] io_uring/zcrx: don't pass ifq_reg to area creation
        commit: eb840beb51bb17da87968f3b8359183bde11be22
[11/16] io_uring/zcrx: split dmabuf unmap and release
        commit: be94c24ce377c528f10176906f2b939d90b53716
[12/16] io_uring/zcrx: unmap under netdev lock
        commit: 6bc4d9dec9059f1373eb140fc80b6f64fd153ecd
[13/16] io_uring/zcrx: move freelist lock to struct zcrx
        commit: 7d5d94fe9af1b402271236ff8536252789f3eb17
[14/16] io_uring/zcrx: keep array of areas
        commit: ef0f0e10ee66d9c96298b5331515f46ab074957e
[15/16] io_uring/zcrx: lock area creation with pp_lock
        commit: 5a22bfdd615bf47a0ea5e11f5090b1011764b3a4
[16/16] io_uring/zcrx: add dynamic area provisioning
        commit: 3c8a5e271594f6ba6d2af40f229cbcd0bcb08c06

Best regards,
-- 
Jens Axboe



