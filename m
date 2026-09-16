Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940749A3CE
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585481; cv=none; b=G1g3jiUiKkWy4UScPqaf61jkr2oP6o6AsgXq/J7B+EDR/o+emufgd09QWzGRFyuc61QYpWtYjdy3bFZIRCQn8SXC+8LQ51NT7Ida4jTkF+sNyeepc46ha2wpnYupQXc8Zb0XWbnC2EoYbqp8JLx4Q/ZSDSrfzrWI1vXuoWoUiXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585481; c=relaxed/simple;
	bh=2V7+oBX3Q6RO7I8OWIVU4rPCk1gBV+kqmoyhRwKxs+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8ayd8lKmhLberl8wzNJGKkNAsqDzGuhpCv0wYOZ4kDoouZT+XXemmlRYSSx4PbwPHyL9nwy9tx1efH2yb47HULU1ULM9Luu1vkmoG+Q0Qf12lpiPfprVlk/xi2ITSRXYLvhHiz1eu96ycxEkuvbppylZ0A9/BpPzqqDijJyUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdqQVnyc; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdqQVnyc"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8b7so5614a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789585454; x=1790190254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+s8uvOEk8cO/1MIMtD9rGwlXQi06EyknvyT6nWqYckY=;
        b=JdqQVnyc8ZxtgM/Zptv3TGAUliO4N847SqLe+MpGgR3OXGl+ic6iZH1iExBacXQ7Es
         VEepN3HaYpke3TOdkSnZqBZCFGWpAkCxNY3KJnyCVdu2kOhVLSrPyqfN+tvG4+mWnL40
         tYf7L5cBw8fjnek22W29Ys9NKrqsQm5aMMK7YM5uf53BZ7wZhFisS1oEdFKKVRsaiMGI
         +ioVwS1fCZNDT1R9pQPPKoKwzF+8yX/Apn7jpNYtMW5mecZFHoY6CGQj2S1UAWuEToqh
         7Ub7LR8K2Z/tx96b88hRrH1Xbmg2umwXJhJM8dJivPbaI0uQHJKWF8o7AszLV9YO5E3x
         fX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789585454; x=1790190254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+s8uvOEk8cO/1MIMtD9rGwlXQi06EyknvyT6nWqYckY=;
        b=qabc7k/aFqevsoGGRvQ2kl3L687YlkB2OOkgl3FhRTLWkLhPOpuR5TMPfAQhPNVecH
         aYnxciqAqpmHIwd2noUORXsEY/DvZmh8DRKd/4V74tMjxw2eccSdHJ5UTAPWVmIlKLzB
         d+XQm4nKrLNHzu+C75IbRtY+GC2Xzq9T0BsDFBlq1nCnF2ELnZVuyOnFMhrpJTj6q83A
         47plUP0KuZsgG8GIHHUsEE+gMRqpohlMhcm22XaIZat5KJqWv+WQ1vBD+TUJ9m4wHzYp
         35TYb4/7VOzMrkcDib0/T7hMlcfIXRzohaF4Jw1bmTzwFWQli2rGqhqW7SAyLh2sMfJ5
         /uQg==
X-Gm-Message-State: AFuF++kf7MtyH0dajtmduXSc70f3bEd6f57oeOme7ZQCVyqSLo+rTOQ8
	4JQ7NlnguJAceIVxhZSVZ5yPMaPo9aK3vXTKb8evkJ9TWjqsHC3+55RhlWTvgeZ8
X-Gm-Gg: AYBFou1f0FKfvjSIhMPtnYxduisdz0IfiUdqMruLa01s6zuar18Hlyi15BjLpw1n/rk
	czEuKmX3QSdaAIe3XgRqkvEBBdVOj2CEWlNUASPU22FgrmeclZBX/jy5eE65NcSgXypq1gaWEWM
	raGDFrEcnv2mJni0t82DFxpfETrSCnyeAkMUgWZhOlN3Izv+s4lIeS/KrZnfA4sFo3U952aliat
	NeIv+ZlTp1jYLcOCg4tXToJjIJNACQQKUPBsP4XIYkghXOSEDjV7csHUzEBdmRpCdIAS9eLpBlM
	DMjFXzuV9ApjMZsFvVqPtSk0regb9ojjduf1wroDfhX2VhRwgR1vJ/QX8YtcVdnddo6fxalgL2Q
	ICnaBlWp8z/beukGpkhifePpiwInOkVFossTbH8DFSs8oKdo8y+wrklJpf4NGBIxmClv9xzBGJc
	osc9H9b8f1kJrUR7BEIidKIt17iK+PIyJF+ltfq8vHeZkreWcfbJLzcNc+Zk8NU2maC0SrPornk
	wQ=
X-Received: by 2002:a05:6a00:4c81:b0:860:507d:503e with SMTP id d2e1a72fcca58-87239f9d82fmr7144658b3a.20.1789585453964;
        Wed, 16 Sep 2026 12:04:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201730814sm1755204b3a.36.2026.09.16.12.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:04:13 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC net-next 3/6] selftests: drv-net: add a system performance monitor
Date: Wed, 16 Sep 2026 12:04:06 -0700
Message-ID: <20260916190409.1222272-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916190409.1222272-1-sdf@fomichev.me>
References: <20260916190409.1222272-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a context manager which emits per-CPU time, utilization, and NIC drop
counters for both endpoints. Use one persistent remote process for
one-second sampling and enable benchmark metrics while it is active.

Tested on two mlx5 hosts. First local CPU sample:

  # # ktap-metric-policy-json: {"aggregation":"busy-core-equivalents","disp=
lay_label":"Percent of one CPU","display_range":{"max":100.0,"min":0.0},"di=
splay_scale":100.0,"name":"cpu.time.usr","summarize":"p90","transform":"rat=
e"}
  # # ktap-metric-policy-json: {"aggregation":"busy-core-equivalents","disp=
lay_label":"Percent of one CPU","display_range":{"max":100.0,"min":0.0},"di=
splay_scale":100.0,"name":"cpu.time.sys","summarize":"p90","transform":"rat=
e"}
  # # ktap-metric-policy-json: {"aggregation":"busy-core-equivalents","disp=
lay_label":"Percent of one CPU","display_range":{"max":100.0,"min":0.0},"di=
splay_scale":100.0,"name":"cpu.time.sirq","summarize":"p90","transform":"ra=
te"}
  # # ktap-metric-policy-json: {"aggregation":"busy-core-equivalents","disp=
lay_label":"Percent of one CPU","display_range":{"max":100.0,"min":0.0},"na=
me":"cpu.utilization","summarize":"p90"}

  # # ktap-metric-json: {"host":"local","name":"cpu.time.usr","shape":"per-=
cpu","time":1.615669,"value":[0.0,0.0,0.02,0.0,0.0,0.01,0.0,0.0,0.01,0.0,0.=
01,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,=
0.0,0.0,0.0,0.0,0.06,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.02,0.0,0.16,0.0,0.01,0.0=
1,0.0,0.0,0.0,0.01,0.01,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.01,0.0,0.0,0.02,=
0.01,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.01,0.0,0.0,0.01,0.0,0.=
03,0.0,0.0,0.0,0.0,0.01,0.02,0.06,0.01,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0=
1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.02,0.01,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0.=
0,0.0,0.0,0.01,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.=
0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0=
,0.0,0.0,0.0,0.02,0.0,0.0,0.0,0.0,0.02,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0=
,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.=
0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.04,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.=
0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.02,0.0,0.0,0.0,0.0,0.01]}
  # # ktap-metric-json: {"host":"local","name":"cpu.time.sys","shape":"per-=
cpu","time":1.615747,"value":[0.0,0.0,0.0,0.0,0.0,0.02,0.0,0.0,0.0,0.01,0.0=
1,0.0,0.0,0.01,0.0,0.01,0.01,0.0,0.0,0.04,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,=
0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.01,0.02,0.0,0.0,0.0,0.01,0.13,0.0,0.=
02,0.01,0.0,0.02,0.01,0.01,0.02,0.0,0.01,0.02,0.0,0.04,0.0,0.0,0.01,0.01,0.=
01,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.01,0.0,0.0,0.0,0=
.0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.01,0.06,0.02,0.0,0.0,0.01,0.0,0.0,0.0,0.0=
,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.01,0.=
01,0.0,0.0,0.0,0.0,0.0,0.01,0.02,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0=
.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.=
0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.01,0.01,0.02,0.0,0.0,0.0,0.02,0.0,=
0.0,0.0,0.0,0.0,0.02,0.01,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01=
,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.15,0.0,0.0,0.0,0.0,0.01,0.0=
,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0=
.0,0.01]}
  # # ktap-metric-json: {"host":"local","name":"cpu.time.sirq","shape":"per=
-cpu","time":1.615814,"value":[0.09,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.=
01,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,=
0.0,0.0,0.0,0.0,0.0,0.0,0.08,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.01,0.0,=
0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0=
,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.=
0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.0,=
0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0=
1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0.0,0.0,0.0,=
0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0=
,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.01,0.0,0.0,0.0,0.0,0=
.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,=
0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0=
,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]}
  # # ktap-metric-json: {"host":"local","name":"cpu.utilization","shape":"p=
er-cpu","time":1.615881,"value":[9.0909,0.0,2.0202,0.0,0.0,3.0,0.0,0.9901,0=
.9901,1.0,2.9412,0.0,0.0,0.9901,0.0,1.0,0.9901,0.0,0.0,3.9604,0.0,0.0,0.0,0=
.0,0.0,0.0,0.9901,0.0,0.0,0.0,0.0,1.0,0.0,6.0,0.0,8.9109,0.0,1.0,2.0,0.9901=
,0.0,2.0,2.9412,30.0,0.0,3.9604,2.9412,0.0,2.0202,1.0,2.0,2.9703,0.0,1.0101=
,2.0,0.0,5.0,0.0,0.0,1.0,2.9126,0.9901,0.9901,2.0,0.9901,0.0,0.0,0.9901,0.0=
,0.0,0.0,0.0,0.0,0.0,0.9901,2.0,0.9901,0.0,0.0,0.9901,0.0,3.9604,0.0,0.0,0.=
0,0.0,1.0,3.0,12.0,3.0,0.0,0.0,1.0,0.0,0.0,1.9802,0.0,0.0,2.0,0.0,0.9901,0.=
0,0.9901,0.0,0.0,0.9901,0.0,1.9802,0.9901,0.0,0.0,0.9901,1.0,0.9901,0.9901,=
0.0,0.0,0.0,0.0,0.9901,0.9901,3.8835,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9901,0.9=
901,0.0,0.9901,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.9608,0.0,0.0,0.0,1.9802,0.0,0.=
0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.9802,0.0,0.0,1.0,1.0,2.9412,2.0,0.0=
,1.0,0.0,2.0202,0.0,0.0,0.0,0.0,0.0,2.9703,0.9901,0.0,1.0,0.0,0.0,0.0,0.0,0=
.0,0.0,0.0,0.0,0.0,0.9901,0.0,0.0,0.0,0.0,1.9802,0.0,0.0,0.0,0.9901,0.0,0.0=
,19.1919,0.0,0.0,0.0,0.0,1.0,0.9901,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0=
,0.0,0.0,0.9901,0.9901,1.9802,0.0,0.0,0.0,0.0,1.9802]}
  # ok 1 iperf.test_iperf
  # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../drivers/net/hw/lib/py/__init__.py         |  11 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   9 +-
 .../drivers/net/lib/py/system_monitor.py      | 240 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ksft.py    |  14 +-
 5 files changed, 269 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/system_monit=
or.py

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/to=
ols/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 349647c2307d..1077930d1677 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -28,11 +28,13 @@ KSFT_DIR =3D (Path(__file__).parent / "../../../../..")=
.resolve()
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, \
-        ksft_metric_aggregate, ksft_pr, ksft_run, ksft_setup, \
+        ksft_metric_aggregate, ksft_metric_reporting, ksft_pr, ksft_run, \
+        ksft_setup, \
         ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_no=
ne
-    from drivers.net.lib.py import GenerateTraffic, Remote, Iperf3Runner
+    from drivers.net.lib.py import GenerateTraffic, Remote, SystemMonitor,=
 \
+        Iperf3Runner
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
=20
     __all__ =3D ["NetNS", "NetNSEnter", "NetdevSimDev", "UserNetNS",
@@ -45,14 +47,15 @@ KSFT_DIR =3D (Path(__file__).parent / "../../../../..")=
.resolve()
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_metric",
-               "ksft_metric_aggregate", "ksft_pr", "ksft_run",
+               "ksft_metric_aggregate", "ksft_metric_reporting", "ksft_pr",
+               "ksft_run",
                "ksft_setup", "ksft_variants",
                "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
                "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft=
_gt",
                "ksft_not_none", "ksft_not_none",
                "NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTraff=
ic",
-               "Remote", "Iperf3Runner"]
+               "Remote", "Iperf3Runner", "SystemMonitor"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools=
/testing/selftests/drivers/net/lib/py/__init__.py
index afad9d5392ca..d779f48ea6c5 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -28,7 +28,8 @@ KSFT_DIR =3D (Path(__file__).parent / "../../../..").reso=
lve()
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_metric, \
-        ksft_metric_aggregate, ksft_pr, ksft_run, ksft_setup, \
+        ksft_metric_aggregate, ksft_metric_reporting, ksft_pr, ksft_run, \
+        ksft_setup, \
         ksft_variants, KsftNamedVariant
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_no=
ne
@@ -43,7 +44,8 @@ KSFT_DIR =3D (Path(__file__).parent / "../../../..").reso=
lve()
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_metric",
-               "ksft_metric_aggregate", "ksft_pr", "ksft_run",
+               "ksft_metric_aggregate", "ksft_metric_reporting", "ksft_pr",
+               "ksft_run",
                "ksft_setup", "ksft_variants",
                "KsftNamedVariant",
                "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
@@ -52,10 +54,11 @@ KSFT_DIR =3D (Path(__file__).parent / "../../../..").re=
solve()
=20
     from .env import NetDrvEnv, NetDrvEpEnv, NetDrvContEnv
     from .load import GenerateTraffic, Iperf3Runner
+    from .system_monitor import SystemMonitor
     from .remote import Remote
=20
     __all__ +=3D ["NetDrvEnv", "NetDrvEpEnv", "NetDrvContEnv", "GenerateTr=
affic",
-                "Remote", "Iperf3Runner"]
+                "Remote", "Iperf3Runner", "SystemMonitor"]
 except ModuleNotFoundError as e:
     print("Failed importing `net` library from kernel sources")
     print(str(e))
diff --git a/tools/testing/selftests/drivers/net/lib/py/system_monitor.py b=
/tools/testing/selftests/drivers/net/lib/py/system_monitor.py
new file mode 100644
index 000000000000..81ded4bea1b9
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/lib/py/system_monitor.py
@@ -0,0 +1,240 @@
+# SPDX-License-Identifier: GPL-2.0
+
+"""Performance measurement helpers for network driver selftests."""
+
+import shlex
+import subprocess
+import threading
+import time
+
+from lib.py import cmd, ksft_metric, ksft_metric_aggregate, \
+    ksft_metric_reporting, ksft_pr
+
+
+class SystemMonitor:
+    """Emit CPU and NIC metrics for the local and remote test endpoints."""
+
+    _CPU_FIELDS =3D ("user", "nice", "sys", "idle", "iowait", "irq", "sirq=
",
+                   "steal")
+    _CPU_TIME_METRICS =3D {
+        "cpu.time.usr": ("user", "nice"),
+        "cpu.time.sys": ("sys",),
+        "cpu.time.sirq": ("sirq",),
+    }
+    _NIC_METRICS =3D {
+        "rx_dropped": "nic.rx.dropped",
+        "rx_missed_errors": "nic.rx.missed_errors",
+        "tx_dropped": "nic.tx.dropped",
+    }
+    _SNAPSHOT_END =3D "__KSFT_SYSTEM_STAT_END__"
+    _NIC_STATS =3D "__KSFT_NIC_STATS__"
+    _CLOCK_TICKS =3D 100
+    _SAMPLE_INTERVAL =3D 1
+
+    def __init__(self, env):
+        self.env =3D env
+        self._remote_sampler =3D None
+
+    @classmethod
+    def _parse_cpu(cls, text):
+        stats =3D {}
+        for line in text.splitlines():
+            fields =3D line.split()
+            if not fields or not fields[0].startswith("cpu") or \
+                    not fields[0][3:].isdigit():
+                continue
+            stats[int(fields[0][3:])] =3D {
+                name: int(value)
+                for name, value in zip(cls._CPU_FIELDS, fields[1:])
+            }
+        return stats
+
+    @classmethod
+    def _parse_nic(cls, text):
+        fields =3D next(line.split() for line in text.splitlines()
+                      if line.startswith(cls._NIC_STATS))
+        return {name: int(value)
+                for name, value in zip(cls._NIC_METRICS, fields[1:])}
+
+    @classmethod
+    def _read_nic(cls, ifname):
+        stats =3D {}
+        for name in cls._NIC_METRICS:
+            path =3D f"/sys/class/net/{ifname}/statistics/{name}"
+            with open(path, encoding=3D"utf-8") as stat_file:
+                stats[name] =3D int(stat_file.read())
+        return stats
+
+    @classmethod
+    def _cpu_deltas(cls, before, after):
+        return {
+            cpu: {
+                field: after[cpu][field] - before[cpu][field]
+                for field in cls._CPU_FIELDS
+            }
+            for cpu in before.keys() & after.keys()
+        }
+
+    @staticmethod
+    def _per_cpu_array(values):
+        if not values:
+            return None
+        result =3D [None] * (max(values) + 1)
+        for cpu, value in values.items():
+            result[cpu] =3D value
+        return result
+
+    def _start_remote_sampler(self):
+        nic_reads =3D ""
+        for name in self._NIC_METRICS:
+            path =3D shlex.quote(
+                f"/sys/class/net/{self.env.remote_ifname}/statistics/{name=
}")
+            nic_reads +=3D (f"read value < {path} || exit; "
+                          f"printf ' %s' \"$value\"; ")
+        command =3D (
+            "while :; do cat /proc/stat || exit; "
+            f"printf '{self._NIC_STATS}'; {nic_reads}"
+            f"printf '\\n{self._SNAPSHOT_END}\\n'; sleep 1 || exit; done"
+        )
+        self._remote_sampler =3D cmd(command, host=3Dself.env.remote,
+                                   background=3DTrue)
+
+    def _read_remote(self):
+        lines =3D []
+        while True:
+            line =3D self._remote_sampler.proc.stdout.readline()
+            if not line:
+                status =3D self._remote_sampler.proc.poll()
+                raise RuntimeError(
+                    f"Remote system sampler stopped unexpectedly ({status}=
)")
+            line =3D line.decode("utf-8", "replace").rstrip("\n")
+            if line =3D=3D self._SNAPSHOT_END:
+                return "\n".join(lines)
+            lines.append(line)
+
+    def _stop_remote_sampler(self):
+        sampler =3D self._remote_sampler
+        self._remote_sampler =3D None
+        if sampler is None:
+            return
+        try:
+            sampler.process(terminate=3DTrue, fail=3DFalse, timeout=3D5)
+        except subprocess.TimeoutExpired:
+            sampler.proc.kill()
+            sampler.process(terminate=3DFalse, fail=3DFalse, timeout=3D5)
+
+    def _snapshot(self):
+        remote =3D self._read_remote()
+        with open("/proc/stat", encoding=3D"utf-8") as stat_file:
+            local_cpu =3D self._parse_cpu(stat_file.read())
+        return {
+            "local": {
+                "cpu": local_cpu,
+                "nic": self._read_nic(self.env.ifname),
+            },
+            "remote": {
+                "cpu": self._parse_cpu(remote),
+                "nic": self._parse_nic(remote),
+            },
+        }
+
+    def _record_sample(self, snapshots):
+        for host, current in snapshots.items():
+            baseline =3D self._baseline[host]
+            previous =3D self._previous[host]
+            elapsed =3D self._cpu_deltas(baseline["cpu"], current["cpu"])
+
+            for metric, fields in self._CPU_TIME_METRICS.items():
+                values =3D self._per_cpu_array({
+                    cpu: sum(delta[field] for field in fields) /
+                    self._CLOCK_TICKS
+                    for cpu, delta in elapsed.items()
+                })
+                if values is not None:
+                    ksft_metric(metric, values, shape=3D"per-cpu", host=3D=
host)
+
+            interval =3D self._cpu_deltas(previous["cpu"], current["cpu"])
+            utilization =3D {}
+            for cpu, delta in interval.items():
+                total =3D sum(delta.values())
+                if total > 0:
+                    busy =3D total - delta["idle"] - delta["iowait"]
+                    utilization[cpu] =3D round(100 * busy / total, 4)
+            values =3D self._per_cpu_array(utilization)
+            if values is not None:
+                ksft_metric("cpu.utilization", values, shape=3D"per-cpu",
+                            host=3Dhost)
+
+            for counter, metric in self._NIC_METRICS.items():
+                value =3D current["nic"][counter] - baseline["nic"][counte=
r]
+                ksft_metric(metric, value, shape=3D"scalar", host=3Dhost)
+
+        self._previous =3D snapshots
+
+    def _register_aggregations(self):
+        for metric in self._CPU_TIME_METRICS:
+            ksft_metric_aggregate(
+                metric, summarize=3D"p90", transform=3D"rate",
+                aggregation=3D"busy-core-equivalents",
+                display_range=3D{"min": 0, "max": 100},
+                display_scale=3D100,
+                display_label=3D"Percent of one CPU")
+        ksft_metric_aggregate(
+            "cpu.utilization", summarize=3D"p90",
+            aggregation=3D"busy-core-equivalents",
+            display_range=3D{"min": 0, "max": 100},
+            display_label=3D"Percent of one CPU")
+        for metric in self._NIC_METRICS.values():
+            ksft_metric_aggregate(
+                metric, summarize=3D"distribution", transform=3D"rate",
+                display_range=3D{"min": 0})
+
+    def _sample_loop(self):
+        next_sample =3D time.monotonic() + self._SAMPLE_INTERVAL
+        try:
+            while not self._stop_event.wait(
+                    max(0, next_sample - time.monotonic())):
+                self._record_sample(self._snapshot())
+                next_sample +=3D self._SAMPLE_INTERVAL
+                while next_sample <=3D time.monotonic():
+                    next_sample +=3D self._SAMPLE_INTERVAL
+        except Exception as error:
+            self._sample_error =3D error
+
+    def __enter__(self):
+        ksft_metric_reporting(True)
+        try:
+            self._register_aggregations()
+            self._start_remote_sampler()
+            self._baseline =3D self._snapshot()
+            self._previous =3D self._baseline
+            for host in self._baseline:
+                for metric in self._NIC_METRICS.values():
+                    ksft_metric(metric, 0, shape=3D"scalar", host=3Dhost)
+
+            self._stop_event =3D threading.Event()
+            self._sample_error =3D None
+            self._thread =3D threading.Thread(target=3Dself._sample_loop,
+                                            daemon=3DTrue)
+            self._thread.start()
+            return self
+        except Exception:
+            ksft_metric_reporting(False)
+            self._stop_remote_sampler()
+            raise
+
+    def __exit__(self, exc_type, _exc_value, _exc_tb):
+        ksft_metric_reporting(False)
+        try:
+            self._stop_event.set()
+            self._thread.join()
+            if self._sample_error is not None:
+                raise self._sample_error
+            self._record_sample(self._snapshot())
+        except Exception as error:
+            if exc_type is None:
+                raise
+            ksft_pr(f"System metric collection failed: {error}")
+        finally:
+            self._stop_remote_sampler()
+        return False
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing=
/selftests/net/lib/py/__init__.py
index 21d89ae76b49..9795a83d662a 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -9,7 +9,7 @@ from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft=
_pr, ksft_eq, \
     ksft_ne, ksft_true, ksft_not_none, ksft_in, ksft_not_in, ksft_is, \
     ksft_ge, ksft_gt, ksft_lt, ksft_raises, ksft_busy_wait, \
     ktap_result, ksft_disruptive, ksft_metric, ksft_metric_aggregate, \
-    ksft_setup, ksft_run, \
+    ksft_metric_reporting, ksft_setup, ksft_run, \
     ksft_exit, ksft_variants, KsftNamedVariant
 from .netns import NetNS, NetNSEnter, UserNetNS
 from .nsim import NetdevSim, NetdevSimDev
@@ -26,7 +26,8 @@ __all__ =3D ["KSRC",
            "ksft_ne", "ksft_true", "ksft_not_none", "ksft_in", "ksft_not_i=
n",
            "ksft_is", "ksft_ge", "ksft_gt", "ksft_lt", "ksft_raises",
            "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_metri=
c",
-           "ksft_metric_aggregate", "ksft_setup", "ksft_run",
+           "ksft_metric_aggregate", "ksft_metric_reporting", "ksft_setup",
+           "ksft_run",
            "ksft_exit", "ksft_variants",
            "KsftNamedVariant",
            "NetNS", "NetNSEnter", "UserNetNS",
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/sel=
ftests/net/lib/py/ksft.py
index f0cbc7307117..e44029213e4f 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -21,6 +21,7 @@ KSFT_DISRUPTIVE =3D True
 KSFT_METRICS =3D None
 KSFT_METRICS_START =3D None
 KSFT_METRIC_AGGREGATES =3D None
+KSFT_METRIC_REPORTING =3D 0
 KSFT_METRICS_LOCK =3D threading.Lock()
=20
=20
@@ -99,6 +100,14 @@ KSFT_METRICS_LOCK =3D threading.Lock()
     print(pfx, prefixed, **kwargs)
=20
=20
+def ksft_metric_reporting(enable):
+    """Enter or leave a scope which enables benchmark metric producers."""
+    global KSFT_METRIC_REPORTING
+
+    with KSFT_METRICS_LOCK:
+        KSFT_METRIC_REPORTING +=3D 1 if enable else -1
+
+
 def ksft_metric_aggregate(name, summarize=3D"total", *, aggregation=3DNone,
                           transform=3DNone, regression=3DNone,
                           display_range=3DNone, display_scale=3DNone,
@@ -219,6 +228,7 @@ def ksft_metric_aggregate(name, summarize=3D"total", *,=
 aggregation=3DNone,
=20
 def _ksft_flush_metrics():
     global KSFT_METRICS, KSFT_METRICS_START, KSFT_METRIC_AGGREGATES
+    global KSFT_METRIC_REPORTING
=20
     with KSFT_METRICS_LOCK:
         metrics =3D KSFT_METRICS
@@ -226,6 +236,7 @@ def ksft_metric_aggregate(name, summarize=3D"total", *,=
 aggregation=3DNone,
         KSFT_METRICS =3D None
         KSFT_METRICS_START =3D None
         KSFT_METRIC_AGGREGATES =3D None
+        KSFT_METRIC_REPORTING =3D 0
=20
     metric_names =3D {metric["name"] for metric in metrics or []}
     for name, metadata in (aggregates or {}).items():
@@ -549,7 +560,7 @@ KsftCaseFunction =3D namedtuple("KsftCaseFunction",
     totals =3D {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
=20
     global KSFT_RESULT, KSFT_METRICS, KSFT_METRICS_START
-    global KSFT_METRIC_AGGREGATES
+    global KSFT_METRIC_AGGREGATES, KSFT_METRIC_REPORTING
     if KSFT_RESULT is not None:
         raise RuntimeError("ksft_run() can't be called multiple times.")
=20
@@ -564,6 +575,7 @@ KsftCaseFunction =3D namedtuple("KsftCaseFunction",
             KSFT_METRICS =3D []
             KSFT_METRICS_START =3D time.monotonic()
             KSFT_METRIC_AGGREGATES =3D {}
+            KSFT_METRIC_REPORTING =3D 0
         cnt +=3D 1
         comment =3D ""
         cnt_key =3D ""
--=20
2.53.0-Meta

