Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B813D3486
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804105; cv=none; b=tscQwMG8jgyn5fdg2AmJcfXMmsMgtD/fBHiqGD4HF6s7LZjDC97OcO97lFQhCabtHBQiYsIstK5+dFDQ5YGXSzweHOrkmUgzzdMJgGpz/eVZwVg5iXh5zJghsmIknfJ9oAbuIubyyFaGyVDtjySwz42qAfQ+bmkRMkAOdME4Bdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804105; c=relaxed/simple;
	bh=Pi44jNN1RheIU5jAZGrUDivLlSm9a01ego4YnZX5mxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEA7Y7bqy3HWT5+1gPsW8bs9m5tGSWaH7A0KUzrnfIoak566yGKC+Ki7Uuu14Yf1di0VU1Vc47C3czQUUMHBA4R0dklyQvw8vZ67vVTdeYecdSmap/toiSwkR0FNT2NKT4vBk5JKvIV0gJ7uRFLT0agbidXlvcavgYUWEzokTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BocS+kbZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BocS+kbZ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845c92bc464so325455b3a.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784804103; x=1785408903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pi44jNN1RheIU5jAZGrUDivLlSm9a01ego4YnZX5mxk=;
        b=BocS+kbZVk4ssW0CvgJniRPEI5HLvaVhleEU1mXbvyijA8m9jeGQaWJSvtM1yiHb3l
         sECMGgvNiPq2XvhUIQOH3YE+t6fmA2TaVKmVVLQSlPQukb7DohEdHek3S3g7+3eUw8CT
         JySBTTi0NXU1wO4eANwMuL2p7gcPoZVc9pncM0j+os9G0EKi3I7tJ9vFDHk4sZxtQOkX
         0/EkAmhp1Iclb0Q2s98bsTtqjK5/EKWh9CwfZShCQO+ZGpTW3tSyLN1ub+lC8tn8FL+2
         4KEE2IJElFRqwn+q9jTN6uOLTzZEJmFFpK7CBudY5i5UfFzR94tISm7tzGuO6JeoSTgJ
         4kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784804103; x=1785408903;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pi44jNN1RheIU5jAZGrUDivLlSm9a01ego4YnZX5mxk=;
        b=ZGLasgWqm/TvJMrJt3NvYCa1PncQS5AGlasIjY+9H/WmKUDUiLDwktZxWsXNvug9f5
         zB8cFmyCpxkV/RMfVnt9HN/SLQbigyTBeRqJa2VWNYsOS0POppZ6ALOe2iASSog4OdSn
         dISYRqZsHJUnw3ZqLi04GvUl+4eIxKR1I0gp6YghZLrMOnmBgwTtKfu8fIl7zEzm7TE5
         w/rEQZUUGFdxCb43VjnMSdKbS2B2SYHjh7099RTBhPckk0wC4PVzjxT9LojPgwS4xHFG
         F9kkFvrDCp9wizqomncwxu11/57Y1AUpYsArHo6v50cqfMmGth5L1tbP/vMLFUyVb7dx
         AXRg==
X-Forwarded-Encrypted: i=1; AHgh+RrVUvxlJi8P4hnMUHuxfUsRgAQhRZXXuzIG6p3p4QPpr/lHXFk3b6D4r7rCAp91JAQ6k8UlYhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5vPReRIO5F2XN0/IEPOiOA6IxXseNR3nIxcL/0h++Q6oICPL
	n3YsupE4pvWqOdu3gEy08VxMJqxE+iMRMEZfsDKSD6Fi4rQTqchv/uvt
X-Gm-Gg: AR+sD133xhE7VptYvwCbmAu7Brs/gRdE5RQKCNp51o2qnZ4nL/iToqfpWVWjdVnyP+d
	YjvWEMaNm0+XSDzZ+NqIbp62ROY2x4+Uq+Nv55ylbQ9LLklsuo/SCFvzDTsRB3dxLkbJSjbOsax
	IlHA9rPcyqhr1bKjYSqfomxKmcNpZhWXma+XrdsEnYv8HPC+WB9bAaj8TH918ElPG+eP09UVU4Q
	FN3rAluyQ7B7xtJXq6UWCPx35PbHxjRSPLvu3eS49PlnrEs34ifg3FK4tvypgzGd+mGEDlrMpHH
	9NkltisDNK0Bn4yOJmV6OHYNQPqV68ShliUTSrAvCsnkFSSn26CwlM74HQ+SvPyIsSHw3sPquAm
	2PCaKEvGD/PKI8cmikTQHJAKy0CwDd/P8UsLpbcUaOq3w163qbhZMnY3bSiYYfS4dtEFkFnt6m/
	eIO+T1
X-Received: by 2002:a05:6a21:1519:b0:3c4:1c9f:d91 with SMTP id adf61e73a8af0-3c44b247352mr2773503637.59.1784804102681;
        Thu, 23 Jul 2026 03:55:02 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1cf8fasm19621764eec.31.2026.07.23.03.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:55:02 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: michael.christie@oracle.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: pbonzoni@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-scsi: flush backend after device ioctls
Date: Thu, 23 Jul 2026 18:54:51 +0800
Message-Id: <20260723105451.1563439-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <3d2dfa19-42f8-4d1f-a411-c72669f4c4bc@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit

The changelog is too long. I wrote it incrementally while investigating
the stale response-HVA case. English is not my first language, so some parts
came out wrong. In particular, saying that the ioctl waits for pre-update
commands may have suggested a full stop-new -> flush -> swap -> start-new
sequence. That was not what I meant; sorry about the confusion. If the patch
is otherwise acceptable, I will shorten the changelog in v2.

I wrote the patch myself. I used AI assistance only for notes and wording
help; it did not author or submit the code.

For this specific stale-response-HVA issue, I believe the patch is correct.
The patch is a return barrier: vhost_dev_ioctl() publishes the new memory
table, and vhost_scsi_flush() switches each vhost virtqueue to a new
inflight generation, flushes the vhost work, and waits for the old
generation's references. The completion path copies the response through
cmd->tvc_resp_iovs before releasing the old-generation reference. There is
no separate stop-new phase or full quiesce.

A command can arrive after vhost_dev_ioctl() returns and before
vhost_scsi_flush() switches that virtqueue's generation. It is assigned to the
old generation and is included in the flush, but vhost_set_memory() has
already updated that virtqueue's memory table, so its response iov uses the
new table. It therefore does not introduce another stale-HVA case. This is
why stopping new commands is not needed here.

An old-generation command may complete while this ioctl is still running in
the kernel, including while it is blocked in vhost_scsi_flush(); that is
expected. The same userspace thread cannot perform the remap and follow-up
TUR before this ioctl returns, because the thread is still blocked inside the
ioctl. The owner must keep the old mappings valid until the ioctl returns.
Remapping or dropping them from another userspace thread before then is
outside the lifetime assumption of this transition barrier.
