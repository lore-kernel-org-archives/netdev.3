Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030037C900
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336705; cv=none; b=B7nG4ri95/HhuGYkXzejag5M0CN3kjo8nxuOUYRP6H3lo9sl8NUBlskGPwQ/6gAf2QVIIDAkBgTb+uoZBmH1xi2YfX5ZVZytXjX4YKoHIia5Zedpdxf7FkcGOCMGRTrQR++n3imVsjJM6wk+z4L8HAhcCcmQIqZESj7VT3lqs2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336705; c=relaxed/simple;
	bh=uupUcokBHEbkXiMRczBa8OiLQEXjW2N2KxeR7enpz5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t06RfrEJvSdZZXHV5rVkWnTQ2eXRtiqQkcp2hXBaDaV9tKtuU+9xp4MxInnbVTIMW5+9YpbnlMZdh9J/5C9CvVT+lrMAefLfSVbAOD9G09T1QfBB/3MfiYvXtZv71G1PZZknPTK/d4dW97hlbq8ceysQjXI2kw8vPuSRQadBwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBqpDqFy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBqpDqFy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3811f512167so1655393a91.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787336703; x=1787941503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qbmb1M/OhKzOHYJkS8FlOj0XoccMSjcMV6VeJEFCrf4=;
        b=EBqpDqFy7wbwF2YQDUqH3VTKeXsf9nQRiYVVGg4uPfqhZ0FJmjVueU5EPWlIc/JVQI
         R9gcnqAMmdorfRIL9HcwwCPN0cjLr0sxaBe4GRSy5NTdbQVOzO2UYs7T1F+6jWSfC91Q
         cPyMP1D0oesH6dwV58lncQZ25NtBc6ElQJNdLTFleW5H/cMuHtf+xBAwPBH9Y9yGzpGC
         JSxIwbh5oCE5quBkC+AEVRcRUkx1qJX+xY3Y8J0TWw+Q05wGrKj4sVJfLHK2eV2t+oHv
         zcxhj/CMM5dV2rg9taQAX1U9MTCw25nK3Yn9tnOa773uweK+10tjd4cDiH606oSKcVRQ
         DAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787336703; x=1787941503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qbmb1M/OhKzOHYJkS8FlOj0XoccMSjcMV6VeJEFCrf4=;
        b=hH+iYi+gqic/uC/35tQcqDkUh82iX5vc6T/Yfovl0BDFWgKMXZCHkk6lVqfcXQgjN0
         yN6V8wTFgi33xkPu5teNeeHF3HLdOcW68OtdoaD6OldpYsPDAlBXa+vXnu/tU9I3O3RB
         rOBaVVvnueiAYu1aoeQ/NYUTImVnyCJtJrgJAAUGNAesmFFXO4Az0/IfqSyafHWStXlY
         tvNR6AlFq5gz04ma6c8JCFjqvwjF/6Pkrn6GxxTX40yGyINEL3iZ9iXLGSFwKEVMTZkj
         lz1FaE2g6Ngj2iz6n1fshrHPKRUJohXdx6vHr+LMXMdODdLQdiU6s4yTM3tnCpwTKTg8
         LYHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrwIV3EB2xxXmJg+DT62CJHA22XSwb4hPgAteeIKrhBVCqoBOO+vbKRQRfNNw27sAg/XhHmvC0=@vger.kernel.org
X-Gm-Message-State: AFuF++lBFOyHHRtTI8er9sN2tPZRLQNKs5u8Mp3Cs6lVnqti20IupR9J
	mwvWyJnnGjPcqZHb8sJlnOcE2tzQrkmAJQ64vbctVcWPqi1mRS656/8+
X-Gm-Gg: AR+sD13CJVIqidWZTLPHLp/tHgnJXU7cWeJwQPEv71ajeYqZjTHvKn5kw7Q1OchCRcO
	/Em7dv5OeboXBZlzHH0IBPorZx6UmtKxOfht/Hw8++VpDoXEGxzqO8h/cRJOweT6V13QLpaIaaW
	o+sGmC4/AEd4PuU8qRnmUsCElHShvPYZbEa9I1QTDBL3YPTGvh7VHKhpJ6PQy66EwkdeSp/ZC9Q
	lT3JBu0IiullVevNwAILCzwZeN/SNKZWrF5zcihoPtzDTVUbcUKouuYPtWol697RAtlbp3lfngg
	8vuYk1CDXHWOCxOkMkForibGC6b4a/C4jmE+mvpg0ONgs0np1bQl5O5+5cLLiV+nIu1u29OZUo4
	Neg3Vfi0S5/h7G/S7T1ppcQMKa0fKtZB1wZc+X8xZXjz+uFuLppU6qUMJkEu0arZSjRfvZbmhe+
	NxTTaQsu0ETTTDiZCi3lAy5+1jM6+tczZXtAYPqiTY+fvNbcklBPajXS5lcuMf6pexeU9EDn38z
	o3DrGGeGeUor4yqofc5LFjr
X-Received: by 2002:a17:90b:390f:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-395c2f29705mr14673128a91.0.1787336703134;
        Fri, 21 Aug 2026 11:25:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1012:54e3:69b5:423e:871a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c45539a1sm4243013a91.3.2026.08.21.11.24.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 11:25:02 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net 0/2] tcp: fix congestion control UAFs in do_tcp_getsockopt()
Date: Fri, 21 Aug 2026 14:24:47 -0400
Message-ID: <20260821182449.79785-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_tcp_getsockopt() has two lockless reads of icsk_ca_ops. Since BPF
struct_ops congestion control made icsk_ca_ops point to dynamically
allocated memory, a concurrent setsockopt(TCP_CONGESTION) can replace
the pointer and free the old object while either reader is using it.

Patch 1 fixes the TCP_CONGESTION path by copying ca_ops->name to a
stack buffer while holding rcu_read_lock().

Patch 2 fixes the TCP_CC_INFO path by keeping the ca_ops->get_info
lookup and call inside an RCU read-side critical section.

Eric Dumazet's related TCP data-race annotation work [1] adds
READ_ONCE()/WRITE_ONCE() annotations for lockless TCP socket field
accesses. icsk_ca_ops would similarly benefit from such annotations,
but that is an independent data-race concern. This series focuses
solely on the use-after-free fixes via rcu_read_lock().

[1]
https://lore.kernel.org/all/20260416200319.3608680-1-edumazet@google.com/

Cen Zhang (Microsoft) (2):
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

 net/ipv4/tcp.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


base-commit: 746fc0787f616da418ffc04a110296fe95d53491
-- 
2.55.0
