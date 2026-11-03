Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706639;
	b=x7XPB+FOauBKg0Lh6aRVwLmQVCFlSZt+F9V5zSfrKCCrV4ZjTdKJ9ySQaZcGgiHwQaSp
	 UlW1Y2cguk8tOl5wDEb9z+Yehebq/e6FzAx2EEzZ0X17O8ltyhT+CNbERUPB5gP5P3ni6
	 yscQy4aN9Ucw3N7mjhzJRjuiNaYt86GyLMiQUFjWSy+HfrcWb+akhoOh6H/3J3uZwg8+Q
	 vb36LCHrhpN++Dh1zpbPIZ5Ggdhg/kC9nUBhRluTvYCTB8nWUB70F1HIp0K5MeexBxzeP
	 +GWv7VmAeGjykXIDAZMgUpEXAq49b9UAfX/1nqFl2KQjoBoEcQAMYFDvrH7qSaNmR5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=K2XfEeUcN1jWTOzmdT3RYJ78fSiNTv4T5ATMrI0edQw=;
	b=eTqSB1hHDpZLLaEEp84fME0pc6KF4ENGyNUBsFwNVnAIzkWJ94gNRuGOlA+lBr77UgDN
	 U5boI1Fd2G6QdYxyndYiOo4d4I6TT/z6gSzu78kxeY9bLN8MqGnvwQu2WiyYVT9v+gZG0
	 d6VBFKSFehft2n9pfQlj7jpuhc3DakxTEjE0ZTdWQ5LcZNl513HMW7JmeLZIlV+gvTaE8
	 RF03nuUlnAORciqzeoiPK50fva1A2OPHQhPZhDId+pLcCfGmlblW46v7ear/12onWDrPt
	 xITMxahTOQwYbXnTbaPCR04R05zz/p3XGD5vEtnoKETImdXGj9+TrZ4cY4WkYiUug4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=SM83Qf9N;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6119606EE85
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6119606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=SM83Qf9N
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b09e07e149so33013147b3.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 03:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793706637; x=1794311437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K2XfEeUcN1jWTOzmdT3RYJ78fSiNTv4T5ATMrI0edQw=;
        b=SM83Qf9NT+SVsUiUy+tTcJBP+bhj27xdLr5TwKW9X3AhPEMUBFKimxyNr36cGB9ybP
         PWWD7bW/bpvEE6UX2ABkt5nox7TMUIHabOtmOqNpki/3A231PcqnuD7DiSnq3wHohoiR
         SnQ+C12ADuw0H7Vo/DhbHdpyPmlSW2yLlyiCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706637; x=1794311437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K2XfEeUcN1jWTOzmdT3RYJ78fSiNTv4T5ATMrI0edQw=;
        b=imDpZ3iScFuzBcHWWk7cMWqs6ssUJL/ixK4Gn2kgXsQYcDQwfo7VivVhgMk7T26CvE
         W13m4bcwh98P/pqYvh5tCH5OOe0kEpAQCmpkSfnPcI0nGk8Ibahi8ROaOn8r1z7Es8AZ
         pjMfjM7Dxb1cMpESaPAW7nx3rQ7/fgTB0k0NeUnWxfdycgX/8WRsXt2M+bECjkx96tw0
         OUeaAk3Lgl/A7KC0OhT+a6aBJv6ihg17VczmljgFh8+VD0r851XwJ29/I48Ic+quEmaL
         5A+pyLdm9VF+1lJ68wIe6JaiDuavDFjXv2clA4jRK49OCAWA+WFekao7k+4ubaqL4gYC
         HWUg==
X-Gm-Message-State: APuU4Z/Iel0TY7VWOGd9WfOmRGSm8bDirDMxJAPkXpGOurXGtgMZ4GBU
	MX2xz6mnT9TQUTgaHbqwJmjBRqg6n3l5iBmFtVY4F8pYOryQ2dkWHHrhWzATW4WavsIjo9QN6Oi
	bOiY=
X-Gm-Gg: AYBFou3ngUf4k+nbACcbNFGdTIQgsgKI8T+NQpe3uL7lPtqWb6YCTL7la0OSMmIR1sF
	ZUmoJf7xW0SlisHccyIx69SsteYpBjOU2JSNH1zdIlP1Xk5R+zdFZvPeJCP53i3wb99jFbj/hnG
	GsEdUPBoRvdg1ZoRtkMuTiEHvhI4B7UBVgDdfduAtx0FOoeoFexYZ1oHqg1giezrir/CMvQRgPt
	L3CWG6kklPToVqx/2GxarQwFukkCYtrHxHUlmqhNzjTFK8VWXuxagXOaY7WqmGTorWLCAZ/j2Bl
	l0FH10wucRUjme+dSi1j2MZmEynJqsomGDWYWzCUhfVHSEzbjkpZqnZ/seKSbq+Ne/+ZQ2qdbD9
	G19i48/aiq/qlCz2iz7TE4IvrxjG9w9T4Gm5MgvXogVkSU1fiSpjbHDpWlFVGMt+71z9C2q6fch
	XZ6sJJbEasVETothCtPJjKXBta8EZyr5zY6dX4S5+ia40A7zCV0Gqlpi1mBTrSsr/3mab/5PD2Q
	uu+DXq4gE/q8MibdpuaSw1MPivRdB7NBpWjacjtt/vKBcLEZ6EyuVMNLeNxrAcatgfrb2/KXeHD
	XpQvCSJQKMsa+d51lw1MzQe+sZAL85F59nxU+IuCoiXyt60QF3EMXwf98F1foEO3dKwd0Qb0or7
	iCPRZmIetEaE045E=
X-Received: by 2002:a05:690c:fce:b0:8b1:738a:b44c with SMTP id 00721157ae682-8b2b66c780bmr74176927b3.23.1793706636793;
        Tue, 03 Nov 2026 03:50:36 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704d699sm70016857b3.5.2026.11.03.03.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:50:36 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Tom Goff <thomas.goff@boeing.com>,
	Shuah Khan <shuah@kernel.org>,
	Yotam Gigi <yotam.gi@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 0/4] net/sched: fix short-skb metadata and namespace boundaries
Date: Tue,  3 Nov 2026 06:50:28 -0500
Message-Id: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

This series fixes three independent boundary problems in net/sched, and
covers the third one with tc-testing cases.

1/4 act_ife: encode a configured zero metadata value.  The u32 and u16
presence callbacks reserve an 8-byte TLV for a configured zero value, but
the encoders returned without writing it, leaking stale skb headroom bytes.

2/4 act_ife: require a full Ethernet header on egress.  An undersized
linear head can make the encoder read past the end of the skb data.

3/4 sch_teql: reject qdiscs from another network namespace.  The global
TEQL master lives in the initial netns; a qdisc created in another netns
could still mutate the master's MTU and flags.

4/4 selftests: tc-testing: cover each of the two teql attach rejections on
its own.  Case 124e moves to the initial namespace, where it creates its
own device, so only the root-only check can refuse it; a root attach from
the test namespace is refused only by the namespace check.

Origins:

1/4: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
2/4: found by Sashiko (nipa and gemini) while reviewing Victor Nogueira's
parent act_ife patchset; independently reported by shaos
<shawnq1@163.com> with a reproducer, which was verified in our test
environment.
3/4: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
4/4: follows Sashiko (nipa) reviews of the v2 posting, which pointed out
that a single case cannot witness both teql attach rejections.

The four patches are independent.  They target net and the three fixes
carry a stable nomination; the test cases do not.  They are sent together
because they share the short-skb and namespace-boundary review context.

Jamal Hadi Salim (4):
  net/sched: act_ife: encode configured zero metadata values
  net/sched: act_ife: require a full Ethernet header on egress
  net/sched: sch_teql: reject qdiscs from another network namespace
  selftests: tc-testing: teql: cover each attach rejection on its own

 net/sched/act_ife.c                                | 13 ++++----
 net/sched/sch_teql.c                               |  9 ++++--
 .../selftests/tc-testing/tc-tests/qdiscs/teql.json | 36 ++++++++++++++++++----
 3 files changed, 44 insertions(+), 14 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---

v2 -> v3: considers comments from Sashiko (nipa) on the v2 posting.  Case 124e
ran under nsPlugin, in a namespace where the teql0 master is not present,
so the namespace check answered it and the case no longer proved that a
child attach is refused as such; the case added in v2 covered only the
namespace check.  124e now runs in the initial namespace and creates its
own device, and the namespace rejection keeps its own case.  Both cases
were verified to fail when the check they exercise is removed.

1/4's and 3/4's diffs are unchanged from the v2 posting, so neither carries
a changelog; 2/4's Fixes: tag now names the commit that introduced the
unguarded copy.

v1 -> v2: considers comments from Sashiko (nipa) on the repost2 posting.  The
cross-netns check in 3/4 ran before the "teql can only be used as root"
check, so every case it did not catch was answered by that check, masking
the assertion that tc-testing case 124e makes.  The root-parent validation
now runs first and the namespace check second, and 4/4 covers the namespace
rejection on its own as suggested by sashiko-nipa.

1/4 and 2/4 are unchanged from the repost2 posting.
