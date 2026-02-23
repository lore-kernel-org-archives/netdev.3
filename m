Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090324DFF3
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854442; cv=none; b=tXCXnv7o+hFL0xjVw3XV7CaZAb2kLlXuukRjqYCZMMvSjJHSVJ5G95LC02vT73f+uNOK80psUsryx6olG+00TraryXhnqwNnOK77VggOtkC8zVcl9g5C4w2xH5Mu+gVYA0lPEF0hC7a81S7tuiv6nLj91Z5KAHNir9IDleqhcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854442; c=relaxed/simple;
	bh=9w+SjGw6n4t29t08fv4rkwYt66K61EqhDXjmeXFpd/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CGFr2oZX4CfXJZ1bR7b1zqolYU6irX0nGdxh0KfUE545EQTnFp6EwSqJ5W2ngojGmgpe03rcTK15ypJ6OOTkTSh2mzCeN9uZ8bMWi6nvnHfAaE88NIjEXYBkpeEJs2PTS5qzR7Lk/xdsfZN5W6RIi4QF+AGbMvK4OKYTpyDHxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ej9nTyvM; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ej9nTyvM"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4be7c4ebeso2611995a34.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 05:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771854440; x=1772459240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xU3SfDvX7n0CH4qpAqG10f1VSdcLt50DI5AjNEC7anw=;
        b=Ej9nTyvMtoArdk+0MMfxny1wod6hSIAs1DvvQtTp2OlV+FmrH9nPVCWu2jDCQXdbLA
         OLoxNCwU6PCDDDQdPO3XRdFabXfZB0QP3ryXLPoDtTjXHVlX38Xk7qAqz52Xy/2NUHxM
         8D+5sVTrZqmZcSa+PSjiACCPLW/ZhMU8XZfjM5c+aj58kx+YBMh2+vnm3EcM7gfzuhDQ
         cN0OGH2zJi6ZpspkxKFfGyK/gAaSTz+KAvNABFrj5TKD0S7CJD26MBjB9ObXqxahHwIm
         4wSW324kNRMOm9h9dkwmlgc4ifDk/vIxwbQQGtbpAuy36cIL42WZGLgcTd2GNoRKFgV3
         0D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854440; x=1772459240;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xU3SfDvX7n0CH4qpAqG10f1VSdcLt50DI5AjNEC7anw=;
        b=oAmLKS8IdCpSU1EDh5m7/agUjK5fFW1kSh84GVzn9ANafyG+UulZ2xpMi+gu+cF3Qj
         cr1dnkkY10rQo85CTSL8FyPlg8mxIqd6yCzLD4gmXsJLKQ1VmxJp2RdrqbnMtJctkY/P
         weqTEAtKuj6Fyvz06emy4n5t0qui11ez+sHVNo9DZN2PzPjnu8b/7AQyclmFOnlr3fnf
         mCFtm9qNIp0F7oIePhiiAuUhbLFBL1cDW3zu4CSrG1NirNa8RVl21HH7WUffh5cnOLQ/
         wS1+GASWF6Z6NrGh0/n7uz1ThJkWJ2TFlM5DP99zHQUGCyuMFFLA7O1gZzatdhpOl0Ns
         hMiw==
X-Gm-Message-State: AOJu0Yy6DIMH+HDiTLNrPtlsLTQ0vXvMa0PzyElscDw5C5u6A3CIDrnk
	eb6XqcDCFAWp7eZYIQBWpkV/602/hgkeRPT/7uUYFOtTBKqaz2pxTa60clf5AqHAgzUugEwpVyX
	4ueNrswaRWA==
X-Gm-Gg: AZuq6aIhBWLMkz0s7m1vr7B2sbgi0glgSjqYsGXK54Jj8dXQ86q1n27Zzot0sgquwTn
	DbEqr7lqCqmVnTrOr0shCrScPBKEc6izzX2AMH2oFzwASA7+WFiJonw05uCOvQmB+SAWwXB4Dsb
	MhC/M403+Q+rqvAyr5ne6mjFsOOHlKdPHzVf7HaOsWk6fpjsbMPw4VeM/Lfq9iqflvyj7NRpyYa
	PRhd3bWlDTNcGY784FwHvH9cJqXK5SRYOybUT/1cIDHEcg7L8fcfKisjFrSULfabcOBucSHpSvQ
	IZrTzfDp7F8h8DQrzz+CGOgBsQsztnn4e5f2K4mn6hGmv6Fp7/oxMGv9ktpK9sO8f4OLxwCVRt0
	pDPTP+xeWJXH6bj48yFM2Rysi3gvtc4b4PyJxdQHKVgnzdsBsU52qTkjlkGnWoqKiLgcV/FuIVh
	kAbT7s+lqKBCvj6dFe7JA7Hy6Wtizlh6uN4+AUId4ccTqe95t9T/UhIeupBMQo9ZAveH0J7VIoB
	0vv
X-Received: by 2002:a05:6830:61c3:b0:7cf:d201:c32d with SMTP id 46e09a7af769-7d52bdf76b3mr4727680a34.3.1771854439829;
        Mon, 23 Feb 2026 05:47:19 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d04dadesm7246370a34.23.2026.02.23.05.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:47:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <b68ff77af39422191154413f262717a08dfc9e04.1771197486.git.asml.silence@gmail.com>
References: <b68ff77af39422191154413f262717a08dfc9e04.1771197486.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] io_uring/zcrx: declare some constants for query
Message-Id: <177185443873.636584.937001806515054998.b4-ty@kernel.dk>
Date: Mon, 23 Feb 2026 06:47:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 15 Feb 2026 23:29:39 +0000, Pavel Begunkov wrote:
> Add constants for zcrx features and supported registration flags that
> can be reused by the query code. I was going to add another registration
> flag, and this patch helps to avoid duplication and keeps changes
> specific to zcrx files.
> 
> 

Applied, thanks!

[1/1] io_uring/zcrx: declare some constants for query
      commit: d4d8bf4122f291571f576da7bae158d1150e5c9d

Best regards,
-- 
Jens Axboe



