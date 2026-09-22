Received: from mail-pj2-f33.google.com (mail-pj2-f33.google.com [74.125.227.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2F522696
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066486; cv=none; b=VIKvvU/zQcjOfJKpGaDzpSH65gnMMwtjc74J048uS82sMg+r3akYft50puHGzfkN4Xb3RigEJBXkxPULMSxRWsRIKMvI6wgLFXl/bhn7IE46BbMpUtR5JC5Dwke468UDEBB2FjV4XJwXEpDSUbwfVDm+I0mDqkYAjMjvU6ISbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066486; c=relaxed/simple;
	bh=vlT2izf++gU8SdYUB/P/44JCuyP6O54Uc1vQ2YVNZk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9cQCtWIhC0eebpEQ7vyFKaqSx1l2ucomhiNyZgCU2qjcu+SHpe12jreL4+VL9NxUoioP9sSwDUaPRhhaIY3ZpXkuDbh3aeRifJkq6Pq3ujfn4V5TevMoyTnsbyvldPQ6EbAA7pdqOZpBL02ESgrKS7Pb2F4WtPMUCqaRAsbLR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0N2MajN; arc=none smtp.client-ip=74.125.227.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0N2MajN"
Received: by mail-pj2-f33.google.com with SMTP id d9443c01a7336-2d747ed1368so45946435ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066485; x=1790671285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vlT2izf++gU8SdYUB/P/44JCuyP6O54Uc1vQ2YVNZk0=;
        b=P0N2MajNTHnFacVoyhoGu8nyjoJSwV8/8iPXlqe/TJAG1eo+wfk/lfJ90m1/i7E54V
         wYQiQNjK9L6UnJjmtozcGzG9dlXIw26fPD1Morv5JI9TzfgsvfsgbYegF3wYWKhiFpfT
         wVz3rYB8Myel97zwCgZRGxpHX1hn0Gt0xWXchaLy/zpDT/ptvNrOWGbq77LlODCb2jgj
         jiCdh85+0JzYJhnTu1B8Lq7HjAA4B1GwiCUdwmc7bJ23lrPPy76tMxVvNj0XlZfcssKV
         fkNTOz2mvkV2SOUDmXD9d2NNB01qwdTYsYmAPcje+BLY2ZSk6/Tq20twCQZLzsbXK6Du
         p3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066485; x=1790671285;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vlT2izf++gU8SdYUB/P/44JCuyP6O54Uc1vQ2YVNZk0=;
        b=KlqOIn7iNhx8W143XLbzSiJeDOF4eGSc9RGqB67xTHi7+p2Q/tico3ywjUyqUM1r+Q
         LujHf5atYz6zCVRUSVGQSjiVrmhciZJ++iopvskG4Jp68eoGNblx32/9X0+3u9TSaYTS
         XvNeI6ldWg2Db+F1yiQToZFlqJUg36ooFY5MW4n7JmtBS2Y9JQv8UOjfXonrOSG3AKua
         OGO554ETf/fYxCoLstTYE8GPycE7qXTAjY5xqSgiFt13wBtVk/HZ+g/pPIDtmtGm+gPG
         BW4wSFKH26VWqy8xADLEsyI8gkB+0GeSImIaQy0GHPKHl/Iaev7gzjHuWKMR3eFYRVsf
         KhgA==
X-Forwarded-Encrypted: i=1; AKwUvBySc5kXLFj59G69gpdErzS52GVW8NwN9yaxwF2Ew/4DlvkOKCG8YXEW4+y7YvOvEg5LE/ZaDb4=@vger.kernel.org
X-Gm-Message-State: AFuF++mu5dq17OSuXPGUm0+2eiimAa+Q48pbBNN/cqxDbwocfSxFkGGc
	DieUrFJJ0eyAhBSKjjh1tI0hucw189yGCtMfSsdBy8Y0jApCWD6QAb7s
X-Gm-Gg: AYBFou0gTgsCSoPxi7tgutYsTyociNsrEG3XICpqAoVIpM5DaKWM2ic/PxyW1s3M9kk
	xanHYnBjrCODXDOCgksgRXAwi6MOuL0cViAf8t2bMN3T410mCWmx9py3I0oJrbVX33ufW2s8bN9
	aBGvk/6B4HUYAJrzI45BSZUx41Wfe2i8ZWyqNpEDVtPbXEfoUFnZ+uxbL+dxZP5e0OUyG7iGqx3
	oTyVCEYpuiUv03xhhCiEXSgcauCyWhMJC8N8avJRa47eKkGXCb2+BJC0icwXtljg3fyMxLqMVPE
	ldr5qPL2NWSTJkEmZvTLSDc3MDjqG36tTYCsFeuF1s7xpIMWORacJUKp/ML5oeL2oS/Eh7gIVTm
	Hg0j6gYl8FMTbxijnRVRQ/5+YYnGYB00DZ28s0wUqvk2UPtf28X4G7NzBSdjlZUvyBntyIG9Pfs
	MdsIlrezdgG/4UjIrX1s7v8MW+L6LB79ul1tKchvN3ESBeVn+Th4nJqR4wvfPkNXmXA9mrdTIQy
	GCxuobTxueG7Z36GEE/Yl875DjdPW6FY8VIB7I=
X-Received: by 2002:a17:902:cf0b:b0:2dd:c053:c209 with SMTP id d9443c01a7336-2df60b3a425mr4756515ad.37.1790066484736;
        Tue, 22 Sep 2026 01:41:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:b519:cd9:fed2:d000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0581f0sm6030875ad.74.2026.09.22.01.41.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 01:41:24 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: Re: [PATCH 2/2] net/sched: sch_cake: check negative transport offset in cake_overhead()
Date: Tue, 22 Sep 2026 16:41:15 +0800
Message-ID: <20260922084115.36844-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <179000041222.2160803.11108326722307773525@kernel.org>
References: <179000041222.2160803.11108326722307773525@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Thank you for the detailed review. All three points raised are valid
and insightful.

1. Regarding OOB read vs shaper accounting corruption (Severity: Medium):
You are completely right. While the negative offset in [PATCH 1/2]
(net/core/dev.c) directly causes a wild pointer dereference via
raw pointer arithmetic (skb->data + hdr_len), in [PATCH 2/2]
cake_overhead() passes hdr_len to skb_header_pointer() which undoes
the unsigned conversion. The real impact is corrupted header length
accounting and inflated shaper durations, not an out-of-bounds read past
the slab allocation. I have revised the commit message to accurately
describe the issue.

2. Regarding companion guard from qdisc_pkt_len_segs_init() (Severity: Medium):
Agreed. When the transport header was never set, skb_transport_offset()
returns ~65535, which bypasses a negative offset check and inflates the
shaper duration to ~66 KB per segment. In v2, I have imported the
companion !skb_transport_header_was_set(skb) check.

3. Regarding segs == 0 underflow in multi-segment arithmetic (Severity: High):
Agreed. When segs == 0 (e.g. from DODGY GSO frames), (segs - 1) underflows
to 4294967295, causing an astronomical duration to be charged in
cake_advance_shaper() and permanently stalling dequeues. In v2, I have
updated the check to `segs <= 1`.

v2 patch has been sent in reply to this thread.

pw-bot: cr
