Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947323;
	b=AV5jFuHIuoS6SQ1I+jYydha1HdMmPv06iHOTo8Fye49TZObPLET98p9o0wucfyd+MlND
	 WON2WlJO6GwLHW/03NjzReBPBdtjlSrPMDKUgk9Q6Gr0gQjG71UU3BygaP2otg/As633U
	 fyb7QMh76CtxvUqA9BcAMWQ4n/9Nmg8ngCjYA1dk7OKeseR7TXA4TWnTz/igj6coM7mK8
	 mis0ENM/RRyOIf8pwok/svMPSDWFGsgt7mebgXh4bf3agfIHPthmPZ82XPFkB5rlOWx4A
	 0f2xu0haaWWSsgVFZ7h+GsVVh7APoe3HV820yaTlnqN4lBO65zouTypS4Z2fiW3VtCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947323;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=SQ426vLxQ2280euxZBJWWN8G4ZPXaNeSNnRUBS0Gfpo=;
	b=VxtWEKu7FwMr6n7x6X/o7JbVj5wjAMrSkgPASws7XEVZAG8MPpHmzCpXFB65qQZYKGfD
	 h/dZ6u9DDoqYr3uKlh+V9kqV+W3qJf6PzN5YqMCzIVodUOLtsqdauBugQY08IOTftEg5U
	 u7lQ6j9uinw282GsSeCmXSw1RcwnzHYkXuQWprE54TVzbsFxt7XzlT7nS+L+uCzd2jJCV
	 aHmSmGvc3kVsiWKc1a8vGhv/CjIE5HMN7Ku0hRdW40P5cEiU0PXEzJ43Fa5f31LO3lwT6
	 YgUPKa+y/ivIGY6tXXjao8j6JW6+zu5Majv4sI2bR/x7Q6pV44mFYkuchte9PcYua1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=Kn5xqePs;
	arc=none smtp.remote-ip=117.135.210.9
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA779606A326;
	Fri,  6 Nov 2026 06:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA779606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=Kn5xqePs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SQ
	426vLxQ2280euxZBJWWN8G4ZPXaNeSNnRUBS0Gfpo=; b=Kn5xqePs/fZLps/QaP
	5E1Nl+0hi4J+S3W/8I2SzKxYkQ4xdFNBbKdQRKDW38b+iIyvdsjNp31UPea4NOYJ
	hKIQ0zPrznR1BRV1xOhz6/MQCXvbfC7guVQjxXlBcB3E1LlckXEHMgmUk92DcmrW
	CM+dZSiGZOnnLHvHvK67MLXBo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnR+uMdu1qZ7kzCw--.3170S2;
	Fri, 06 Nov 2026 14:41:17 +0800 (CST)
From: Linkui Xiao <xiaolinkui@126.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net/sched: get_fill_size() budget fixes for act_gact and act_vlan
Date: Fri,  6 Nov 2026 14:41:11 +0800
Message-Id: <20261106064114.3592670-1-xiaolinkui@126.com>
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
X-CM-TRANSID:_____wDnR+uMdu1qZ7kzCw--.3170S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy3Cr48XFyDWF48Zry3XFb_yoW5AFyUpF
	W3W390kr1DJryxAw4xAw48Xa1S9wsxAFWUWr1fGr1S9Fs5Ww1fAFyrKay3WFyUCws3Xa4j
	qr4qgrnrWrWvyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlQ6JUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQ7WrWrtdo54WQAA3C

The get_fill_size() cleanup began with commit 8e2efb3f45a5
("net/sched: add get_fill_size callbacks for actions missing them")
[1], which fixed the actions the bug was reproduced with, pointed at
act_gact/act_skbedit/act_vlan as the pattern to follow, and left the
other pre-existing issues to upcoming patches.  It continued with
commit 4ba61bfd4998 ("net/sched: add get_fill_size() to the five
actions that lack one"), which spelled out the rule the callbacks have
to obey: size every optional attribute unconditionally, because reading
the current flags to size it conditionally races a concurrent replace
that can flip the attributes between sizing and dumping.

Auditing the remaining callbacks against their dumps turned up two gaps
in the very pattern 8e2efb3f45a5 held up:

  - act_gact reads tcfg_ptype with neither tcfg_lock nor READ_ONCE() and
    budgets TCA_GACT_PROB only when that read happens to be non-zero
    (patch 1);

  - act_vlan never budgets the two PUSH_ETH addresses its dump emits,
    and only escapes overflowing because the three PUSH_VLAN_*
    attributes that a PUSH_ETH instance does not emit happen to add up
    to exactly the same 24 bytes (patch 2).

Neither can overflow today.  All four consumers of the value --
tcf_get_notify(), tcf_del_notify_msg(), tcf_add_notify_msg() and
tcf_reoffload_del_notify_msg() -- allocate at least
max(attr_size, NLMSG_GOODSIZE), and NLMSG_GOODSIZE is
SKB_WITH_OVERHEAD(PAGE_SIZE), so a batch has to carry enough actions
for attr_size to grow past roughly 3.7 KiB before a 12- or 24-byte
shortfall matters.  A replace cannot interleave between sizing and
dumping either: RTM_NEWACTION, RTM_DELACTION and RTM_GETACTION all take
rtnl, and the classifier path, which can run without rtnl, computes
attr_size in tcf_exts_validate_ex() and discards it.  Both patches are
therefore accounting-correctness fixes against the rule above; each
carries a Fixes: tag for whoever wants it in stable.

For completeness, act_ct, act_tunnel_key and act_pedit also size some
attributes conditionally.  They do it from a single rcu_dereference() of
a params pointer that replace swaps rather than mutates, so the budget
stays consistent with the snapshot it was computed from.  act_gact
instead reads tcfg_ptype, a field mutated in place on the action itself,
with no lock and no READ_ONCE() -- that is what patch 1 fixes.  act_bpf
sizes conditionally too, but takes tcf_lock to do it; patch 1 removes
the read instead, which needs no lock.

Patch 3 adds TDC coverage for the previously untested gact dump and
get paths.

Tested by building net/sched with CONFIG_GACT_PROB=y and W=1, which
produced no new warnings, and by running the tdc gact and vlan suites
(38 and 36 cases, including the three added by patch 3) against a
CONFIG_GACT_PROB=y kernel with this series applied; all passed.

[1] https://patch.msgid.link/20260816201327.2435335-1-victor@mojatatu.com

