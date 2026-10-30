Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340079;
	b=x3f7IlK9hCRBKrOyZaQpTm/J7iA3KxkQUOjgxH5V1pGj54WTHAEtQo0cb1NBqHLSBMTl
	 59TKz3i+rdjmUiZ76rsqIqqI8u9/nLVb+o9JgW035AIGl0ISfgqRY9M4kpt7f/1xkrU2P
	 K9EYrDRVZXuzffMkBjVdKzCdiFbxIGo95vKXOKY8zMG3NWD4dWPVVO3s0v7Y/UAFDtI7G
	 K1eI6TSovskm2tnKSakkZvb2k8yQX6qryhsRUUFmtk3+WLQRCIYrNsgUImQcRnmcLm9R1
	 p/dn7uxgF8zTEU7M/wmX1/SyxyoethXd62yw5/XNxC5Up61df78ytY6N6X5TOScR2Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340079;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=SNo6lEnp0YEeshRc8RFLr5k4atQhnLvqusrNkgI6V88=;
	b=ZLGuTelYfAyeKgZjX7dR4RRdCdr3iG0YESqEGsD1HyScQyo3Z/Z3yZZftJSDzgX/pnEa
	 v+r0anowmRxEkNm1StGjzHtssaEvM+CjU2Fvg48NFQiMhzZ7aVCD/T+hmyCCa42+TAaeF
	 ge/3g5vk4bq7gnDNufL3rghc3/fw6zuzcqqV0ahzJv4hujL0iPpsIT88EVKAQg+C7PkjC
	 myXjb45xhNaRdUA2JM0REefM54JPj0KQpVl0guMLosC+tgrIged4zyERmHthlaY3gw1RZ
	 Ig2e+Bgpkhnw9JmTJpfhJPocVevruLYLaMD1YVsMSFNw5eWNSEbONEW/C4E+xFuWLbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EW59JHFu;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F7606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 961F7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=EW59JHFu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SN
	o6lEnp0YEeshRc8RFLr5k4atQhnLvqusrNkgI6V88=; b=EW59JHFuDEdX/0U7Pe
	ccrpwJhongPxuoCdM7D6loBTY20VY6S9qLLitwh5uOCb1gbgq2voBJqBsUa6Jv0x
	ea0Exlrz/bO8E0gDK8aH4rXHKTBdu3yl/U+NQQTw7w/S89mHdhf/gS4KJ/x1aXt/
	FHhul4gdBSmA2HDbmZX+64m78=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXb1WNMuRq0UhWEA--.43024S2;
	Fri, 30 Oct 2026 14:00:46 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v9 0/2] tun: fix re-attaching the socket filter
Date: Fri, 30 Oct 2026 14:00:41 +0800
Message-Id: <20261030060043.94719-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXb1WNMuRq0UhWEA--.43024S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF43Xr1ktr18GF1kAw1UKFg_yoW7Jr4UpF
	WrW345Gw4kWrWxWwn3Zw4xZ34ayws7GF45ZwnxG34rZan8Wry093ySg34YvasrArZ7Ww1j
	yF1jv3ZFg3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4g+D7mrkMo9DsQAA3B

From: Rongguang Wei <weirongguang@kylinos.cn>

This is v9 of the series that fixes attaching a queue to a TAP device which
re-installs the socket filter of a persistent device.

Patch 1 keeps a copy of the program in the kernel when it is configured,
instead of reading tun->fprog from user space again on every later attach,
and fixes the inverted error check in tun_attach(). The two changes are
one patch on purpose: with only the kernel copy every re-attach returns 0
without publishing the queue, and with only the check fixed a re-attach
that used to succeed without a filter starts to fail. IFF_NOFILTER keeps
working and is no longer needed to work around the re-attach bug. The
program is verified with bpf_prog_validate_classic() when it is copied in,
and the copy is committed only after every queue accepted it, so a program
that is refused later, when it is built, does not replace the saved one.
The header is zeroed before it is filled in, so TUNGETFILTER never copies
uninitialized padding to user space.

Patch 2 adds selftests: it re-attaches a queue after the buffer the program
was copied from was made unreadable, attaches a second queue from a fresh
socket to check that the filter is rebuilt from the kernel copy, and checks
that a TUNATTACHFILTER with a bad length or bad instructions keeps the
saved program, plus the ways to attach a queue without a filter.

Thanks to Willem de Bruijn for the reviews, and to the CI reviews for
the comments they raised.

Rongguang Wei (2):
  tun: keep a kernel copy of the socket filter program
  selftests: net: add TAP socket filter attach tests

---
v9:
  - zero the whole sock_fprog header in tun_copy_filter(), so that the
    padding TUNGETFILTER copies is not uninitialized stack
v8:
  - narrow the bpf_prog_validate_classic() contract to the classic
    verifier and note that it can also return -ENOMEM; a program can still
    be refused when it is built, and the commit message now says so
  - commit the new program only after every queue took it, so a late
    failure does not replace the saved one, and filter_attached is left
    alone
  - selftests: check the filter state and a newly attached queue in
    attach_filter_bad_prog_keeps_program() too
v7:
  - verify the instructions in tun_copy_filter() before anything is
    replaced, so an invalid program is rejected even when no queue is
    attached
  - fix the kernel-doc of sk_attach_filter_kern(): drop a reference to a
    function that does not exist and complete the Return section
  - reject a program whose length is out of range before allocating
    memory for it
  - document why the filter is dropped when a later step of tun_attach()
    fails, and why filter_accept[] has three instructions
  - selftests: add a case for a rejected program with valid length and
    bad instructions
v6:
  - add description for return value of sk_attach_filter_kern(); no code
    change is involved
v5:
  - add kernel-doc for sk_attach_filter_kern() describing what the missing
    original program means for SO_GET_FILTER and sock_diag
  - mention in the message that a rejected header now leaves the installed
    filter alone
  - fix the wording of the mprotect() comment and note what the IFF_NOFILTER
    and TUNGETFILTER checks in the re-attach test
  - https://lore.kernel.org/netdev/20261012021113.45939-1-clementwei90@163.com/
v4:
  - merge the kernel copy and the error check into one patch, so that no
    step of the series turns a re-attach into a silent no-op or into a new
    failure
  - charge the kernel copy to the caller's memory cgroup
  - selftests: check that the queue is attached again, and attach a new
    queue to see that the filter was installed from the kernel copy
  - https://lore.kernel.org/netdev/20261003063859.136895-1-clementwei90@163.com/
v3:
  - reorder: the kernel copy of the program comes before the corrected
    error check
  - add sk_attach_filter_kern() in the patch that first uses it
  - address the review of the selftests
  - https://lore.kernel.org/netdev/20260930080746.135017-1-clementwei90@163.com/
v2:
  - roll back the filter attach when a later step of tun_attach() fails
  - keep a copy of the program in the kernel, so that a later attach does
    not depend on the address space of the process that set the filter
  - add selftests for the re-attach and for a rejected TUNATTACHFILTER
  - https://lore.kernel.org/netdev/20260929093712.131096-1-clementwei90@163.com/
v1:
  - https://lore.kernel.org/netdev/20260923025653.59348-1-clementwei90@163.com/
---
 drivers/net/tun.c                 | 127 +++++++++++++--
 include/linux/filter.h            |   2 +
 net/core/filter.c                 |  67 +++++++++
 tools/testing/selftests/net/tun.c | 249 ++++++++++++++++++++++++++++++
 4 files changed, 433 insertions(+), 12 deletions(-)


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

