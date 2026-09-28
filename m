Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331E493626
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605895; cv=none; b=s7mnbvUiZoOGek//mx+2P2x8cFXL/n3oZ799BFe/8wJjfKdVmh2kcpuMTc5P+Gj1RbcnhKykw2wnItre5E6yb/QI3RWZCp2LdC//Dbv2jejyfodvFcEL8IG/tqkoVg+R243jQBwq8F34ol00O/aQLObvg9Vw8fImGMZaWu6xc64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605895; c=relaxed/simple;
	bh=D3TXq3ux30ZNnfK6lC/HKLzji/G3Th4nc3cSemt7ugs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qev4reIUJ4eKs6cKbqh+EMKch8w3mJiJQ5Vzou7hgKLCXFAvb2jJkf/Nyo0n0AKgJrDzU5684VlsIZLpJftypYASDWASle8Ux+T+5nJKZT/yN3SY9UBwSFaFB+CcVrhJcn7wtCL4wtnuuHt5HmdtMK4g46oO7QCJviXwuobq+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=00aMNaGV; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="00aMNaGV"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f7915355so2641849c88.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790605884; x=1791210684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1z8ZKhhaN5u9NWisVj47vzqbZOwB7wmqGzyey1IEdyo=;
        b=00aMNaGVqCsBfl/3kMvAjybg2Vic0g0YqY2HqJTRC6Q2Th1V1wJyLgQVmlOTsHSDb4
         AKEa80v6S0UlWvhwrEY82BLapMF+5Lt1A5A+ucnzCQAC0zGPeXaSy2uKZs78+Kvt8pbJ
         fb9dtu2ZNG5ZEXe45PgSkKfJUHoNqg0qNF+s0ydacdGlcQwxHxeXErNaukIeHKexvMTG
         eHgw5rO0e0o9+rL0OTSHkc+AragEgST6rVHV5cjXDeZl3DiEfvBAMulO8gXjf9B1CAu/
         3ZxYr/g+YMDSYPSIqm2NenDTIKVTHTZCOGsNI7Xm/h0BD9eeaVRiqZuKwvGBXlyROsd+
         bMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605884; x=1791210684;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1z8ZKhhaN5u9NWisVj47vzqbZOwB7wmqGzyey1IEdyo=;
        b=aOimLAL6U9M4qb8zBUaZVo3+XA1tAA3UPxouRfSMC178U2eHYHpWXRzBkpN3Zo2HZ7
         daidRzqjID3YixSyyuDpn4jwHrdQigXmaXnaKUltK+QJtxQM4eh8xtYnRne4ZSX3uAeY
         v2U6BgqJl46XPE4ls+cSOkIC5F6xNq+D+Bkor53mcn+kBpBPgZ368rI/8Q4tSjDuWHrj
         lzNcOs1qyz5NzVlha8qXqv+qy+HSHWtY7Oh3TmkJ+URh4jY5VhSuSV8mMlgH5CJIlkcC
         RObA1x08aCyQQuj0as95YCNl/2nQR/1WxuKJI2DqWUwWPe8ppgRUimzMaPa9op+PklSK
         OlYA==
X-Forwarded-Encrypted: i=1; AKwUvBzA9qJHBYbah4UiQBLSOSrNKC/Jk1nt+KfDZF49MBEX/OxeOZF6kAAiAZKT0N+D+VL7Fy4haUw=@vger.kernel.org
X-Gm-Message-State: AFuF++nM2Lr39UPeDfP97k3wfKb8tTb6RHovbmEXzAlCaxBBH1dg6Lzu
	ifyi+dpJGwCWidUK1QffccNlIVt1GbhTGNtkxdaP1rmGGd8RJlqBUsQAmgFQtOJ6da5L2/oBKdG
	xGvHzA3U=
X-Gm-Gg: AYBFou1zn07yeomeeJWk8ylILX+HzUBWQA+B1ZfK3Y3N4hEjnv6g8Mffxw7+q3v3vmL
	djhA7wdlj7fBjl1WFoQcmXbazUj1Zx6VlcHm6a7QJZak5MId9FDrRxqcWoCgTsC9dSvcuZK+Eyj
	gSfZ2Hk0vGwt3IEAU0JKGE8QcN24YD5pWlVLrs1DXwqHYA38c2Q4cuLI8MJV6VSDyF/ZmeztXsx
	2dQS9k4eH6RTWJhtdIyjIa/q+4bCbABxaocvJhkEed+cq/MDbG1+J5CtZzy1oRmhnBsPmb5iXc6
	8HcVtIFB1Y7h3vlQQqy+cjpSwOVlOE4px8/DuH4AghQdGxStmGFcW5tpzftXqgc1GDWm+FVCZ33
	1ehDVVLN42JRbsZzjXq2MlVDd1V7Ff3l2TnmPkSgG5ApsbQ4Eh/rjY0bEfbnIGwwHJbyioWP9Ng
	Pv3MFPcZ//Tn65AQ3e/+N+/wPlbi7YV3zaoNqFkmQPjT/AEH5Xy9LMPjEDZG3xG2kS4pFm9MMJ9
	ARLnjwrUBBBNHeBLDV0IKQNtGrBOXgupbAMbiF1Lq+lygmWHQcMvDEmaQ==
X-Received: by 2002:a05:701b:2616:b0:144:edc5:32d5 with SMTP id a92af1059eb24-146cfec8ddcmr8983096c88.22.1790605882718;
        Mon, 28 Sep 2026 07:31:22 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad9e097fsm28616577c88.13.2026.09.28.07.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: lollipopkit <a@lolli.tech>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260927074206.65427-1-a@lolli.tech>
References: <20260927074206.65427-1-a@lolli.tech>
Subject: Re: [PATCH] io_uring/cmd_net: end TX_TIMESTAMP multishot when the
 CQ is full
Message-Id: <179060588158.984285.6234217255544312653.b4-ty@b4>
Date: Mon, 28 Sep 2026 08:31:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 27 Sep 2026 15:42:06 +0800, lollipopkit wrote:
> SOCKET_URING_OP_TX_TIMESTAMP arms an EPOLLERR apoll multishot and, on
> each error queue edge, posts one 32 byte aux CQE per timestamp skb. Aux
> CQEs have no overflow backing, so io_uring_cmd_post_mshot_cqe32() fails
> once the CQ ring is full. The loop then stops, splices the unprocessed
> skbs back onto sk_error_queue and returns -EAGAIN.
> 
> -EAGAIN is IOU_RETRY, so the request goes idle until the next poll
> event. io_arm_apoll() forces EPOLLET and draining the CQ does not re-run
> the command, so the spliced-back timestamps stay queued until an
> unrelated later timestamp produces a new edge.
> 
> [...]

Applied, thanks!

[1/1] io_uring/cmd_net: end TX_TIMESTAMP multishot when the CQ is full
      commit: 3a3d93070c5ec8b8049d57025987ba313420bda9

Best regards,
-- 
Jens Axboe



