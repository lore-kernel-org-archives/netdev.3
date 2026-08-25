Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4136D488DB2
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672584; cv=none; b=eg70XKoY5WR3DAfeMBSG+Be2IjmCuxxK73h1pG+oq8W3t0mae9LpL+NQKcdD6S1brf7YPvaYvR+uFuZtOdF0qinZrOYO5JIfuYwt02q0FyIQ0y9Bed+7BoXkEV53YHS66KEKxwXSxi/2TCpPeYdFkZh9w7mibIU+pEUJA4BNa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672584; c=relaxed/simple;
	bh=fhiQy2OV+cVozCzA7BSCdsrQ7zEt4QGoeZmCdVvGFro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgS+pdXVJ6I/uNeEPAWpLKI7fGLodojFWJ2gEynqyLes76aez6s09dwZXSMMp61tsXADl5R1gWsg3YFl4d4QMhmdB0e64MG1RYwHN3QKzZLO7/EVIrr9KeHbw08eNxzSHtc4m24WduhdWcWA822H27d/y2sHVRiECMQH80L7ImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ckt1bpky; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckt1bpky"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d58efc7356so54583875ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787672583; x=1788277383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fhiQy2OV+cVozCzA7BSCdsrQ7zEt4QGoeZmCdVvGFro=;
        b=Ckt1bpkyFwWg1EvlI4uGlY8G3cO5IES3FcAaseE44jO/8wvNJRGpwCJ/bUhmomKDae
         5H0y5nVG7xbzwrp+HTQ5D5RSvGUiahAe0MNj0+CEveTo5fsk6gLQ2+RRBvbplSDIQFgK
         2dwSBuRurkY9zNB7LIIPSqfzIPndlcsktWFtYoudJxyWD2LSsXYfHw3Gk734Pz73Jurp
         obFoxpNWbWqpY/0ivjSFDW1H7aWdPZkyf6ohg6ahxmSUzpO1S+Gzx2aF1x5Jfzflprfz
         aSOhsxOJ6B4yh0Dp12NOdMueW0ujNLVYSf//tPB0ssYEOsPdC2jhHlfQ0H5qrsZ+udmF
         reqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672583; x=1788277383;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhiQy2OV+cVozCzA7BSCdsrQ7zEt4QGoeZmCdVvGFro=;
        b=skgVN7BMJPGjvMla1ROBHGmwPZqL4DewsGmPESR5rNP30dtjiMKBq5tarldmgqrDiw
         819Q+O7BYF3M0dyzCMHqEXJGKYUDOQ8LcWMYvD9/zsBp607/fJBaRlDfFfGMabRbdXeX
         OTdSS9O/6T1i4ofQ0FzgNjfE2NSGRB7Nn4Ek57+X+XF/ah22THhSRQmEfaZWsKe+cdwK
         nM6ZW6CiDnWo8Mc/3fH9hVDZ+xVTRaYwftKoH/mzri4rqifhFYvZKQ9Ce7tama3/ig5J
         +kxrP4tRfrG9ctmExeg7jwe9KQoO8my2hC/dvkhtXWkWtcJxcYCQEpFgGRNK5iRlDwbl
         KPPQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2Cil0069daYIGv7sOeigJnFVsXwuZFTGQECp9qhb+mZ375J5PX+VLF/HM5dhggor70fyNW88=@vger.kernel.org
X-Gm-Message-State: AFuF++lxJJDSDpBQ5BR13wz7b3CnfyNkJZfXQAHo5TNl1cXv5endbkef
	juEbKTp6QdWXB4rHPWjmCu+QYEFfMkLTnkKMXmT9V31yl+l7bAls8POd
X-Gm-Gg: AR+sD12Up/ccsFN6++yrglHg6dRLr99SrGiuWcVV1cVfFven6IZzTQWITWRvwqNNjB8
	Gd4icpyTYObpP07Hl1+sHq6gKC5GO0Zt5yoCrLG9x2q0G3j4ay8HnFTCN2NBdNyGxxFlEiLVtfg
	rH/u5C/rDYFjUQBSj1WL9Mo0ru3hce84BA4YFbOpXZ88R1nyh8QRkzORQiPQhnzs6Rih51eWi94
	nl3+imRQZsnErt0fqtuuEcICra+JdT+JODo9OZdgstIHpOV+2+6bgQCOuGIvfp0YUc2rRIP9w+J
	daS+JM0R61yUWj+Ph9EpvChGxnhjemAFUgNC8za0XVUmsbk1oh1igLnJEsDWSHLKaPinYzybcNE
	/pS0fCwxvtv6K2GLIl4aUc7WVuhczatryyQTJAANfLDINjbBoZeWorgXkcop5FZiZR7V9MOGKjD
	PlwydMMXho+v+8hlDLh99DcZr5R7OxGt4b9JP9jb3LnzhWjfPJXorgGXd/eZvJrwjfgSvQSgGFy
	vP3wk+m45BrTqV/xw==
X-Received: by 2002:a17:902:e803:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2d670bb0a3dmr468059675ad.4.1787672582533;
        Tue, 25 Aug 2026 08:43:02 -0700 (PDT)
Received: from localhost.localdomain ([103.210.91.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0a59sm46306748eec.9.2026.08.25.08.42.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 08:43:01 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: daniel@iogearbox.net
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next] xsk: Fix circular locking dependency in xsk_bind
Date: Tue, 25 Aug 2026 21:12:54 +0530
Message-ID: <20260825154254.86328-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
References: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Daniel,

Thank you for the quick review and pointer. You are completely right —
I missed that xsk_notifier() calls xp_clear_dev() while holding xs->mutex,
which acquires netdev_lock_ops() internally.

Please drop this patch. I will step back and do a more thorough analysis
of the full locking design between xs->mutex, net->xdp.lock, and
xp_clear_dev().

Thanks,
Khawar Ahemad <ahemadkhawar123@gmail.com>
