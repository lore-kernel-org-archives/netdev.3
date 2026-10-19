Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429350;
	b=3GUVyDQ4Pi0KZPc3iY5/tEWefiEmQlvTjQb0uC/mQoAX8pjLqjmoJJzBQBJLUlVsh3C+
	 KN0tBDipGrLeTaQENVQ3sdVwvLy43XojU/8TTEcaYvb8RRJQ+bz1hcVhqZdmu/pnybsWR
	 kRRIV8vJR0T1Vh/3LzdB0lb3ZC/NWiI3fOGbDzLe1GilWPhRFbYnZ1Ho3LhmD73VgYm3z
	 1mBFEwC1pmy/bUxIoYY4JtnldsiVfNoqc+ZNlG4PNEDGZFpgnuobSWhQ6iiiH8PVyqo11
	 TEywpd2QFjuKgd/W2QCLAU01+aiLvRj59+7veZZqOKYEEoHdK3fY6PQr8AyEGdohJjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zgafyIzMsT1pjWtIoIB1zWf6MuLMC07egBrhlZEEtIw=;
	b=0S6oLRAerd0mbkgAMfIboQLLlOpnsEIqUGHrTr4g+VmoBr0oruPDR6LVg0kFNFBoFrcT
	 fK5t5Jx8EesJHlDrUDzEf1aDIaz7RO5sEERp7ykjXBltUNX9GVcKcWunttHKMrEkep4zo
	 os263vmLmAyifP106XCp6vfSv/zX6GtlFv0bOCLWjsf6ki9KDpIVh2gsN52jeUZxBGac3
	 0S2wWELwW+6CS2pCtHpgC7WP3tTJh9Q0FYFIc5HMyzwXADwqma8hdD/bvqkgroKqsNEm7
	 9Zz16uP8fV95Ai5Dohpb9spie0lnFnyLu/pyz6ein/nt62wi6iAd3+O0u50aruPhdOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HC5cA4or;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745ED606A31E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 745ED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HC5cA4or
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso335353266b.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429349; x=1793034149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgafyIzMsT1pjWtIoIB1zWf6MuLMC07egBrhlZEEtIw=;
        b=HC5cA4oraBsT/6Cwj86YWowEwNgxxDxLSPOYc+6lXZ3rsXcwEVJvZIblo0j4CiRFvL
         jjwHY/vNZiHW1XIBeQlXHYLhCydDbpq6FiSXLNb0oKgCRacCIY8lvi2tbYk7NiPqn7Ya
         KF7bDcWlIz6e97FaTZiBx89FG2+6E27z9c6hhXcT5/RhX45xrlf+AxVc1KH7jII7dbCb
         9rcJ0/8TgY35/D50dHimFJwIB9B2OxsZpNHTssPZth/wUdSYX/h2Xww/EtbeOh9QD1yq
         feEWZccbrMnQliubCuSUyQu08pi/l0lpiW7cQlto8P6pbMiy4lZ2s3+BV9Gz2tdBt2qH
         iaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429349; x=1793034149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zgafyIzMsT1pjWtIoIB1zWf6MuLMC07egBrhlZEEtIw=;
        b=pekjFb3H/X8D8mG5vsMYY7TsMhGeJiOM5EQC47eTjCfD+4xnA0yZT5trdQYtZPEofl
         BMCmdXG1wfY59fXFcjdVgNYOqbpuwzK1/ok38NafdnHUfre2EwX1DPkKmY/HJ7EJrNK4
         UaPsrsxhpEvwNJbzH7K/WrQBMM5ByHs4ntbXFY9hJXpZ4P/JY+DDs+YJxlT4QQIG/hCT
         A96i77gp1Chkk/pfTMzqQy7pyGYS/6JnS/TdLKaKsBaJp0/MoW20Lg1YL+yjKNNuXm68
         9I0JfDZ803HGL7AceZAXAA1ur+AFsGdfeeNMHVf2ounWCc+nToQucDIIHgOa1hgqoWts
         sKUg==
X-Gm-Message-State: AFq9FYJGNNUFF1csgENVsS9V5Inv9B1P4qx2lYFbuyKfutF2rmp5LwVH
	wILnA5N9EN7cuNLANQMeGT54FfTUepqyDFR6WqDw5PZ//Uc9oO9lTeXZs6ONsEtZ3iu9Xg==
X-Gm-Gg: AYBFou0AhYJ1ai/EHTA8katrpfQhA/zUVndXHa9mGeyKP/4Ra7N5S4S0bMMebhUBLuj
	caqEY4Nz4+rl3Y52S5HVR9ZAxHFO6o+bL4TJfs9IwHiA9TcjWMzDNQSSpudjG7zHAR2F8RTPDOj
	pe6HiMRjIophlAksgbBL0Ey6Khwro9jxSAVshVyye07fyT0qvzhFLzElRjLzVw1u5pYrpBVjKZO
	bR/nJCPwWcK8WlSSX5tYclbpuWEbjcld7PcLy+qw7xZzILiaOGixvQt4Rz8SHafkfjG1iYxVQxY
	by8o5RQzmcayidLpL8ibSihyLPBnj/qA1724l7yk4xo8QwqPJrFqfOVeSKuVldrulkLH1rmAeyu
	1j3Ke2PxGtZ7LGX/WKqSFS8CziGHwkAPNsfuJU3LMJTcBi+3UHlnBSGpP7CcXU166XdmUCQX8bi
	tDqWKJq4UniejZw2vu1MvXaHhqSFMaoBT/mUWOo/SUA7meAyM6xGYiSsIZiOh7UnKL
X-Received: by 2002:a17:906:1012:20b0:c41:b4e4:7958 with SMTP id a640c23a62f3a-c41b4e47ad3mr361011966b.0.1792429348652;
        Mon, 19 Oct 2026 10:02:28 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:45::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm391036266b.61.2026.10.19.10.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:02:28 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Vlad Poenaru <thevlad@meta.com>
Subject: [PATCH net-next 0/2] net/sched: don't wait for RCU when destroying qdisc lockdep keys
Date: Mon, 19 Oct 2026 10:02:23 -0700
Message-ID: <20261019170225.729789-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Vlad Poenaru <thevlad@meta.com>

On kernels with CONFIG_PROVE_LOCKING, every qdisc except ingress, clsact
and noqueue has a dynamic lockdep key, and destroying the qdisc calls
lockdep_unregister_key(), which waits for an expedited RCU grace period.
Replacing an mq root destroys one qdisc per TX queue under RTNL, so a
single "tc qdisc replace dev eth0 root mq" waits for that many grace
periods. Commit 7a3cedafccf8 ("lockdep: Speed up lockdep_unregister_key()
with expedited RCU synchronization") made each wait shorter as a
temporary workaround until hazard pointers are available.

The wait is redundant for qdiscs: the qdisc is freed with call_rcu()
after its key is unregistered, so the key's memory already outlives an
RCU grace period. Patch 1 revives Bart Van Assche's
lockdep_unregister_key_nosync() [1], with the grace-period requirement
spelled out, and patch 2 uses it for qdisc keys, as Eric suggested [2].

Boqun was concerned that a nosync variant is hard to enforce and review,
since a later refactor could move the free [3]. For qdiscs the RCU-deferred
free is not optional: datapath readers find the qdisc under RCU, so
freeing it synchronously would already be a use-after-free regardless of
lockdep. Patch 2 also documents the requirement at qdisc_lock_uninit().
The hazptr-based replacement for the wait is still under discussion [4];
if it lands, the nosync variant can stay as the no-wait path or be
dropped.

On an x86_64 KASAN + PROVE_LOCKING kernel (64 vCPU KVM guest, 64-queue
netdevsim device, 214K lock chains) this removes 5.3 ms of grace-period
wait from each of the 65 qdisc destroys in "tc qdisc replace dev eth0
root handle 1: mq".

A separate lockdep patch, sent to tip, makes the zap_class() part of
lockdep_unregister_key() cheaper [5]; the two are independent. Nilay
Shroff's pending "lockdep: Fix subclass resource leak in
lockdep_unregister_key()" [6] touches the same function as patch 1;
whichever lands second needs a trivial rebase.

Peter, Boqun, Waiman: if patch 1 looks fine, an Ack for taking it
through net-next with its user would be appreciated.

[1] https://lore.kernel.org/all/20250203175939.3133477-2-bvanassche@acm.org/
[2] https://lore.kernel.org/all/CANn89iLvu_ijSV+FnrZ6qei_Ty2c9V-RjwLMk24+oOS91bNjaQ@mail.gmail.com/
[3] https://lore.kernel.org/all/Z-OPya5HoqbKmMGj@Mac.home/
[4] https://lore.kernel.org/all/20261005171529.1378809-9-kunwu.chan@gmail.com/
[5] https://lore.kernel.org/all/20261019170018.699298-1-vlad.wing@gmail.com/
[6] https://lore.kernel.org/all/20260727182312.3750145-1-nilay@linux.ibm.com/

Bart Van Assche (1):
  lockdep: Introduce lockdep_unregister_key_nosync()

Vlad Poenaru (1):
  net/sched: Don't wait for RCU when unregistering the qdisc lockdep key

 include/linux/lockdep.h  |  5 +++++
 include/net/pkt_sched.h  |  3 ++-
 kernel/locking/lockdep.c | 36 +++++++++++++++++++++++++-----------
 net/sched/sch_generic.c  |  2 +-
 4 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.53.0-Meta

