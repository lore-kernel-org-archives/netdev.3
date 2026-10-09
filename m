Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A8337107
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519338; cv=none; b=FJ7Qztx9TBQo8kwMp9RSCawOqxbfetR/Saj8yvCFW8hW577ss2pqEkOkXkFg7ReQ6VqubvcHP8D7nC6CLL02G7mbjzZRMDpaURjWQ3zJbyFCZI/Oj3CtwiaT8V+/sCbYY2lN3L4m/85vVbiYDgcwxC1qdYdDgZ7za5AClGesgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519338; c=relaxed/simple;
	bh=obDhGb5RLj9PYZ2eyCinsmiE9t59PJFY5sRh7w8PNpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMo9DdY2LdenkoZTEletNhR7HuAO1gXwaJ8iMG5Q43P+EvsTsbruL87VtaLukMspSi4T9jnfnJmumpq3A3BWpMPwU+SeTg0CUpK6DUwlgcrzALXGpsaQHOivRXyCqseZGb8/i3tHETyvJzdDWpHt5WulWBJZXUehG7CsqdkscOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=kZpnoeZP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="kZpnoeZP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93cc31c18ebso238539885a.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 21:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791519319; x=1792124119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GnWq/2eDeNny1MK29b1wAOjSKjT1sD+08M0tNeVnBUM=;
        b=kZpnoeZPlcvKM0n9ji/eQOOihiVhLVb5lnDDkenAEGA2XoYdXbHy9WCxh5xn7CHsgu
         FoVXGD0WEgKcg8pT5pQwBYqyGT25XPl/ejMgHN9mIp/2UGkumZUz5woaEWJR4Y5vi7WQ
         U8QUwch5VMisthQTiBIGfnsSfzgpHVuhdDGas09I+JGCyg4aWI7jLhoeGQeLez0kdCOw
         rxBF775qHoZoj3yTp9SvgCRZFdLuZUSMy8KmeR50pHOdpZWKnM7/Imp3mD2Z674WoZkW
         sxCzQt6RzRLEr8bfJ5XcSxV3upYwloV81lExbTX9FnzavZDS7/5+y+K+co8FAPTht86J
         BKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791519319; x=1792124119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GnWq/2eDeNny1MK29b1wAOjSKjT1sD+08M0tNeVnBUM=;
        b=K2w2v5yTH+h0D27nGUjl6fR/JX4ezK7tv9qo4KUcuVTsD7AfYZtLs6DDyjbwD5b1gp
         yIz/4/nZiKzjGgqzvYYmdDDRCwkftQSxZQdm/kpzEW6GEeFcPBZKEcEHWKfXz1ewF5Ll
         jnIWJgCE0hcXUNZc50HpM3AvGyfmDEeonCFq7X8rO+aWBCbS9a7S+aXpGXTKMJRd6y2o
         sTVsUMX7Atj1KNpNlRSTS1j7IjHoJvxN338Y81Suepn9ODM/fNrwJRtG/9p1cDUKMFrn
         R0Ik5g1Copp1s069MFko6IQE93plinF5IkzrMAeq3KSTDiZFJPEbZVRLaBbCvEqHasGk
         LAAg==
X-Forwarded-Encrypted: i=1; AKwUvByYaljQRzM9fbN2y07GIXn0i0FIWAa125LphE3vFqkWgUb0uh+3F2X7fKEhH87rh1vfIXZVTYU=@vger.kernel.org
X-Gm-Message-State: AFuF++nBOUDirK3vmIO44SroT9v7Xk8jqY6SiGOyCatWGIcoZXznlMZm
	wnDtkNhUXxlf1YaIDFK5BL5BZyKcs8qMaa8VnAMNI/BQupbdoR8gdslF8gxdj8lUYQ==
X-Gm-Gg: AYBFou0o1eoIuAtrMy9X4gDzG/yAZ+iVIbMoNsJ5K+6ykJmulxcRZBNxh1dTKT5LchV
	MhYyvDWTSEA9pdnhw/igMRHnvucUtk+PQBCPVOf45IuyaNg00zmvDlQ+BnM+a1xZPI3okZcQ9UE
	gYvM+QCKIdrGJcKyZjNdIX9/rlD+fuLsGHXYGzsL7DGrYC0W8iIL4e//r7HkVa4b+m1BlNgIAC1
	gaBsPQKR01NUF8MXqeYe1keJAY1OJSctMKJUJwjxLXzsVl0vBFezukKoHs9LPXCBujm3xQT4if6
	zK+p38bgBR4gGNhPeVz8LTmryEl8GWZceFZMhZlVFdM6eBbsZC1TCPw+OZp2+qdtsTFShl5QoYD
	/cSgNqgkl8WXabdop+xhUGAnri0OwIVvGrBQ2ixt7BS3EnrH3VPh2U5NLWe0Q738yzIHqalfgCg
	hGH4JT3dpsveAho4XZBjssuwjQ+c1Tgx7adpArpJdQrFaPtJ3SuqMvdGbxRuYhD5gxBkMU7IRpl
	lJ2hJj93VQEAICf5qOhOg==
X-Received: by 2002:a05:620a:17a3:b0:93e:84e5:3c66 with SMTP id af79cd13be357-93ebd21ffd0mr104850285a.40.1791519319093;
        Thu, 08 Oct 2026 21:15:19 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98906c3sm96184185a.26.2026.10.08.21.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 21:15:18 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] io_uring: do not charge user provided SQ/CQ rings to RLIMIT_MEMLOCK
Date: Fri,  9 Oct 2026 00:14:55 -0400
Message-ID: <20261009041455.1974346-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3b9d9c06-c6e8-4166-87d9-c7c220ad0b58@kernel.dk>
References: <3b9d9c06-c6e8-4166-87d9-c7c220ad0b58@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/8/26 1:11 PM, Jens Axboe wrote:
> Honestly, after taking a closer look at this, I think we're better off
> with your original patch and one on top for pbuf rings. Please check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=io_uring-7.3
>
> for the top 2 commits. If you can re-test one more time, that'd be
> great...

That works for me, and the two commits look good.

I tested io_uring-7.3 at 9f0c88b7f884 as a user without CAP_IPC_LOCK and
the default 8 MiB limit. Number of objects created out of 64, with 4096
entries per ring and 32768 entries per buffer ring:

                                        v6.13  v7.3-rc4  9f0c88b7f884
  rings, io_uring_queue_init()             64        16            64
  rings, io_uring_queue_init_mem()         64        21            64
  buffer rings, IOU_PBUF_RING_MMAP         64        15            64
  buffer rings, user memory                64        15            64

30 processes with 142 NO_MMAP rings of 64 entries each, which is what 30
PostgreSQL 18 clusters with default settings create, all get their rings.
On v7.3-rc4 7 of them do.

The per-user locked_vm count stays balanced over ring create, close and
resize and over buffer ring register and unregister. Registered buffers
and IORING_REGISTER_MEM_REGION regions are charged and refused past the
limit as before. Every liburing test gives the same result as on the
previous tip of the branch (c746673517c6).

For the buffer ring patch:

Tested-by: Hengyu Liang <hengyul@cs.unc.edu>
