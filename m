Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579833;
	b=iaxuKiOvqcXlrPCqe/Awb+0pd9WY+OdImrHyx/0aP7p5XmJPPPo+mDVlOqver0VO2EZp
	 OKLRtOWzA7ekroTieiW4XdJo9u8ZUvfP2SwboPaJYCd0Q0nxfJAartfaf7aDuLY1fJaHY
	 CqVn14DtzKt7ANF4F3iiFaW5isTQ5kjcxWWpAcKXdMrVHMz6xNePOE8baexXhsvfa7jQv
	 CaPtykdpG9hD6z2FwRX5PXxRgjO9XxFtaO6cFGMq/J+rmTpA4spai86iArOfsCuOJ9kYx
	 DjE0sPFM5Yt+cRuFDqaoyQfaZK65+3b1HR1J19vNR0xA6HhHYJQmhvFw4xbWE1n6oQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=IUnfnMCfJsbvpWvyHSjvGcJGybGXt1oQn5zqqiFkIO4=;
	b=umSpI9wwg20ltaUE16yvdVnUyKBY9gPs2YIJopDDdLk9QTz7JNC0+f1n0ooszqel5AW+
	 JHShhQ2X0SoJ2tTQOLBRAy2ItAQ1KQeGfjqJ0ZSDWqc6r4ynsjzvstvIHkWYjw52ulcVx
	 sDvSnes7oSHsNb89aUcU1cKHCj8qFZibC4uFrM62SitD0XTHIiYxTEkJlBACJ0WWFrgu+
	 TRI47j4dvwXMKyR3aMGCaZLHr4Qdp2Q0KyUmgc1Cyo06eplYTYlb1wMNBOuabxNkuVES2
	 Lbn7w2P04pqEmaF7+pjrfq66UkUlY2VgXxMI+RHyZg3TI4C9b7Me1Ck6PnH07k3y7ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Eb8N64Y5;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0180606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 00:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0180606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Eb8N64Y5
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91b8306b9f8so45011536d6.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 16:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793579831; x=1794184631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IUnfnMCfJsbvpWvyHSjvGcJGybGXt1oQn5zqqiFkIO4=;
        b=Eb8N64Y5rqXemMKPCivG0+BhZ0l8xEhRnb+UBOUx7NAZ18szy4xG+lWskVUGA9ZL7a
         qw/Iy26lxR7dcQ5PM4iM0Fmss4c64hSMcN8LA30nX7cKoZrrzRaxRp0ssP7UU8cgd/AM
         OLSP2r+pEtG/bLfz0cmUtbmxk4ibNlJaToqqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793579831; x=1794184631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUnfnMCfJsbvpWvyHSjvGcJGybGXt1oQn5zqqiFkIO4=;
        b=S/VXRRiBjdnhWrx5lvJDKTi9Q5Sf6wBoeyoR07R1lQhIxeEEmmkAl+217HpLUHwI6j
         iqz1Zsfr96F0u19ECKsXKVQUC9SZVPG1NZtJfKESkN1Hinu8qDFUTN35LhzHpSDzbdgn
         LorfEBvHDZETOK89GMIBUGPHNuqNLIpS1WtZ5WpeiyuzrurUH6EYFajuk4x0COmE6KE3
         hNXxiVHsi80R/XLdSBFWSVE0DCBZbiYAPOwfb6eD85MQEyzehRph4g82njOsd66bDzVD
         PF1e62LynOKvzXaJ6kTU1fthDpu2pJwtKKwWx9O8/K1VpPVhBeORRKu5p2g6GoIbLK1f
         3Ouw==
X-Gm-Message-State: APuU4Z876WeCXRiCHq+MmUbsZgNmQvheoGpIN0ecGoo18fc+5n95qYFR
	FwUKVvS5kL4myqW8QEpe0Gs4ls0pKNaBze10g+NWWUprGYqDv62n0OUk6/LYSrmj9WXJYoaqoQT
	3fvk=
X-Gm-Gg: AYBFou3hmg80/u9BEPZqSmQKzoCSQmnjPLMqx7R4LVzFo6pRZdrUuEM6EUcRSfpAaAx
	6xcHrlH7JycZsraYBVhgwFxzQ7RaEIkfSkYrQph1uKqcn5MzInEMZQkRv4uypZYx8RFT60OGgoO
	EauhGd35gaNzvfqPGWP9MdutgVCTj21jMAQ73Xo/A1N5W4AXXd1CVZ5sVoGGUJwgVBz2oShcwzq
	1nK4ucFuRU11XKTBj1Yw2RWqc7/MaQ4muvmgWljTo3cV4aKsW1bipgm/5CgP7qNyGGQfiXr31vb
	55DWB43OLcaWjrxdf9iPQODywemH1XUU/MxMX1/CfuGE0M1mkQ+smlVc2KWGkWgcEjziU/CtndF
	cRdIUthjUOuiLTPAZSkbSHre/bf6EnfCMeJ5yRowBUnjtdrI1ZKkFE1sUynLqA3azd1nSmaJ+b4
	DKzPzU//aV8OF1Yby+zMt1nUG7V7rwCMVugUS93ljka96uwaPnc2VblzxFpSqzPzuLEm4A4545j
	X/j33fDeOuddHpajbJ9GjewWFMT9CTbv6KjhO2cL2/tOz7wG65HWSkmxLdvhqYB5BRYze37cJfe
	4kVMBdesW/dvHiBEVKwb0YEZTP2E125/L4QU0dCH79d6nJpT4lIw9OpHa16zgGkuqapzb8c0fGy
	hAmoOWeAT+sJM5Go=
X-Received: by 2002:a05:6214:21eb:b0:919:85a3:313e with SMTP id 6a1803df08f44-91ca4b32cb1mr132715186d6.17.1793579830838;
        Sun, 01 Nov 2026 16:37:10 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f23754sm77043066d6.9.2026.11.01.16.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 16:37:10 -0800 (PST)
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
	Vega <vega@nebusec.ai>,
	Tom Goff <thomas.goff@boeing.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 0/4] net/sched: fix short-skb metadata and namespace boundaries
Date: Sun,  1 Nov 2026 19:37:02 -0500
Message-Id: <SER-NSBD.v2.r0.20261101171325@mojatatu.com>
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
adds a tc-testing case for the third.

1/4 act_ife: encode a configured zero metadata value.  The u32 and u16
presence callbacks reserve an 8-byte TLV for a configured zero value, but
the encoders returned without writing it, leaking stale skb headroom bytes.

2/4 act_ife: require a full Ethernet header on egress.  An undersized
linear head can make the encoder read past the end of the skb data.

3/4 sch_teql: reject qdiscs from another network namespace.  The global
TEQL master lives in the initial netns; a qdisc created in another netns
could still mutate the master's MTU and flags.

4/4 selftests: tc-testing: cover the cross-netns attach rejection.  The
existing 124e case attaches a child qdisc from nsPlugin's namespace, so it
is answered by whichever of the two rejection checks runs first.  This case
attaches a root qdisc, so only the namespace check can refuse it.

Origins:

1/4: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
2/4: found by Sashiko (nipa and gemini) while reviewing Victor Nogueira's
parent act_ife patchset; independently reported by shaos
<shawnq1@163.com> with a reproducer, which was verified in our test
environment.
3/4: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
4/4: follows a Sashiko (nipa) review of the repost2 posting of 3/4, which
pointed out that the new check masks what 124e asserts.

The four patches are independent.  They target net and the three fixes
carry a stable nomination; the test case does not.  They are sent together
because they share the short-skb and namespace-boundary review context.

Jamal Hadi Salim (4):
  net/sched: act_ife: encode configured zero metadata values
  net/sched: act_ife: require a full Ethernet header on egress
  net/sched: sch_teql: reject qdiscs from another network namespace
  selftests: tc-testing: teql: reject attach from another netns

 net/sched/act_ife.c                                | 13 ++++++-----
 net/sched/sch_teql.c                               |  9 ++++++--
 .../selftests/tc-testing/tc-tests/qdiscs/teql.json | 27 ++++++++++++++++++++++
 3 files changed, 41 insertions(+), 8 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---

v2: considers comments from Sashiko (nipa) on the repost2 posting.  The
cross-netns check in 3/4 ran before the "teql can only be used as root"
check, so every case it did not catch was answered by that check, masking
the assertion that tc-testing case 124e makes.  The root-parent validation
now runs first and the namespace check second, and 4/4 covers the namespace
rejection on its own as suggested by sashiko-nipa.

1/4 and 2/4 are unchanged from the repost2 posting.
