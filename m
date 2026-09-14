Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3C381B1A
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789421244; cv=none; b=JhkKeJ0ahlYzES3Olvo5WmfqpjlflOt4F33WyZvb2vsTQXScphM0+jtCNBROnGi2sT/Dtd/UDzATz4n4lENSujEjTR5C6jcZmXG4X2ymBwzavcaBLg4dekcLz1tFaUxyWaMhDtU43dyH4veoqsCU9E0GJ8bkjFA5UYbrZE0L1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789421244; c=relaxed/simple;
	bh=AEACGB8RuVSalid/zfU7q+lhkfwiiELVlg/P+9oPV60=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XO8G5M2jeG1WvCO37OYfopsdU4aYY0eksIAFkssEL/GSPZnZ+6zlEPeQnI6a5iHE5IOJByKmO126OtzekCdeLtEx42CnxjVikg7cgmVYsxAxaphHXZQ0EBEkLdasLF2jiSkJnUN8ccBl+T2Xjvz6lPphNFdP+HGycGGP97GBuwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-801706d7e6dso1648879a34.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789421241; x=1790026041;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MvTOuoUEOFOEOY/RihZs4NnWfA+1/+2IGlAZE7o78mk=;
        b=XIBj+f+I0I4vAJnJnyXjQukCjOwWwjBKYNRPELwCu578iFtIkXud0xwJEa+CnWvxjY
         x8w5K6/UYDFcWPTXgpCt0WtZwrWQxCNAZsIp4p/zDb+jO1igC6Jyb6ZXa2QNNC/GgrSx
         JRdaxWU6dZjwuLpstD3LV5Nh+CW9YCL50HekMSVdPiZ9AjEa/l/AYyVXog3X3kP3NIDC
         rF6bDQn99Tm2gRde+EM0H+yjvIHMpodza0BsF6sP3k7zKqWBM6NNKfg0V0wG47QUJqEV
         iZ30kESacX3cKS+uqEqyUvuKght1eOBXbmC5fOFOlXOM/uD5BkOLH6aTOnqA+wi5eGPS
         B+eg==
X-Forwarded-Encrypted: i=1; AKwUvBxisj4KsEa1W+CdcXIXAsf93A5DneST3T9c3jY2/FK2cRrlD/MOM0n+wq23k3dXIKIFz6BNUyg=@vger.kernel.org
X-Gm-Message-State: AFuF++kmpOt2idToqybiEh2qiU5tYz4By3jXohACPBx5ZLr/G/piG2Cm
	EEZoP/VApuby2OPOKnbaRFFg3K5ROvziE4TtOvV+s4ryvBqjrEiQIz8v2GR9dgDqNy3157NQ44q
	/AL92bHUislOBuAalhcVZt6WNKVOxSn1qFW4SS7xUxIKQiZhxffzZxo6GQdY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4de3:b0:6b9:6c3c:9492 with SMTP id
 006d021491bc7-6c542d250afmr2545261eaf.64.1789421241205; Mon, 14 Sep 2026
 14:27:21 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:27:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa866b9.a211d2ce.1a5198.029c.GAE@google.com>
Subject: [syzbot] [arm?] BUG: workqueue lockup in wg_packet_encrypt_worker
From: syzbot <syzbot+ce2a09d03fdc079a46e9@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    5445d6419962 arm64: Don't read GMID_EL1 when MTE is disable=
d
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=3D17fa6925580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D56ed23170c168d4=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dce2a09d03fdc079a4=
6e9
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-=
1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8b70e3bd109/disk-=
5445d641.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5227e56ac93/vmlinux-=
5445d641.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54905f78be59/Ima=
ge-5445d641.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+ce2a09d03fdc079a46e9@syzkaller.appspotmail.com

BUG: workqueue lockup - pool cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 stuck f=
or 47s!
Showing busy workqueues and worker pools:
workqueue events: flags=3D0x100
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D14 refcnt=3D15
    pending: 4*nsim_dev_hwstats_traffic_work, vmstat_shepherd, psi_avgs_wor=
k, free_obj_work, 3*ovs_dp_masks_rebalance, 4*psi_avgs_work
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D4 refcnt=3D5
    in-flight: 24:reg_todo for 142s
    pending: 3*nsim_dev_hwstats_traffic_work
workqueue events_unbound: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D14 refcnt=3D15
    in-flight: 12:cfg80211_wiphy_work for 140s cfg80211_wiphy_work ,59:cfg8=
0211_wiphy_work for 132s cfg80211_wiphy_work ,42:cfg80211_wiphy_work for 14=
4s cfg80211_wiphy_work ,40:cfg80211_wiphy_work for 125s cfg80211_wiphy_work=
 ,1241:cfg80211_wiphy_work for 145s cfg80211_wiphy_work ,1165:cfg80211_wiph=
y_work for 145s cfg80211_wiphy_work
    pending: 2*macvlan_process_broadcast
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D10 refcnt=3D11
    in-flight: 8217:nsim_dev_trap_report_work for 0s
    pending: 2*nsim_dev_trap_report_work, crng_reseed, toggle_allocation_ga=
te, 4*nsim_dev_trap_report_work, flush_memcg_stats_dwork
workqueue events_power_efficient: flags=3D0x82
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 1425:reg_check_chans_work for 73s
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D9 refcnt=3D10
    in-flight: 1162:crda_timeout_work for 127s ,1254:check_lifetime for 110=
s ,8218:gc_worker for 10s
    pending: hash_ipportip4_gc, fb_flashcursor, nf_flow_offload_work_gc, 2*=
neigh_managed_work, wg_ratelimiter_gc_entries
workqueue events_dfl_long: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D6 refcnt=3D7
    pending: 6*defense_work_handler
workqueue rcu_gp: flags=3D0x108
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: srcu_invoke_callbacks
workqueue netns: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D6 MAYDAY
    in-flight: 8(RESCUER):cleanup_net for 138s
workqueue mm_percpu_wq: flags=3D0x108
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: vmstat_update
workqueue ipv6_addrconf: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D12 MAYDAY
    in-flight: 2822(RESCUER):addrconf_verify_work for 84s
    inactive: 6*addrconf_verify_work
workqueue bat_events: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D50 MAYDAY
    in-flight: 2854(RESCUER):batadv_tt_purge for 8s
    pending: mayday_cursor_func
    inactive: batadv_dat_purge, 2*batadv_bla_periodic_work, 2*batadv_dat_pu=
rge, batadv_bla_periodic_work, 2*batadv_iv_send_outstanding_bat_ogm_packet,=
 batadv_dat_purge, batadv_bla_periodic_work, batadv_dat_purge, batadv_bla_p=
eriodic_work, batadv_purge_orig, 2*batadv_iv_send_outstanding_bat_ogm_packe=
t, 6*batadv_mcast_mla_update, 4*batadv_iv_send_outstanding_bat_ogm_packet, =
batadv_purge_orig, 6*batadv_iv_send_outstanding_bat_ogm_packet, 3*batadv_pu=
rge_orig, batadv_iv_send_outstanding_bat_ogm_packet, batadv_purge_orig, bat=
adv_dat_purge, batadv_bla_periodic_work, 5*batadv_tt_purge
workqueue wg-kex-wg0: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    in-flight: 4710:wg_packet_handshake_receive_worker for 52s
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 8221:wg_packet_handshake_send_worker for 0s
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D5 refcnt=3D6
    in-flight: 4817:wg_packet_encrypt_worker for 47s ,4306:wg_packet_tx_wor=
ker for 47s
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker, wg_packet_encry=
pt_worker
workqueue wg-kex-wg1: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 8225:wg_packet_handshake_receive_worker for 2s
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 14:wg_packet_handshake_send_worker for 20s
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker, wg_packet_encry=
pt_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue bond0: flags=3D0x2000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D5 MAYDAY
    pending: bond_arp_monitor
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker, wg_packet_=
tx_worker
workqueue wg-kex-wg1: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    in-flight: 9:wg_packet_handshake_receive_worker for 48s
    pending: wg_packet_handshake_receive_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    in-flight: 26:wg_packet_handshake_receive_worker for 44s wg_packet_hand=
shake_receive_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    in-flight: 8216:wg_packet_handshake_send_worker for 0s
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker, wg_packet_=
tx_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: 2*wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: 2*wg_packet_handshake_send_worker
workqueue krds_cp_wq#2/0: flags=3D0x20002
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D4
    in-flight: 8219:rds_connect_worker for 11s
workqueue wg-kex-wg0: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 4902:wg_packet_handshake_receive_worker for 3s
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    in-flight: 865:wg_packet_tx_worker for 53s wg_packet_tx_worker
    pending: wg_packet_encrypt_worker
workqueue wg-kex-wg1: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    in-flight: 4802:wg_packet_handshake_receive_worker for 51s
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker, wg_packet_encry=
pt_worker
pool 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D47s workers=3D10 idle=
: 10 4809 4898 4708
pool 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 hung=3D0s workers=3D9 idle: =
8222 5105 8220 1089 4812
pool 8: cpus=3D0-1 flags=3D0x6 nice=3D0 hung=3D0s workers=3D16 manager: 822=
3
Showing backtraces of busy workers in stalled worker pools:
pool 2:
task:kworker/0:8     state:R  running task     stack:0     pid:4817  tgid:4=
817  ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: wg-crypt-wg0 wg_packet_encrypt_worker
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7270
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7449
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7473
 __local_bh_enable_ip+0x20c/0x35c kernel/softirq.c:480
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:237 [inline]
 _raw_spin_unlock_bh+0x3c/0x4c kernel/locking/spinlock.c:245
 spin_unlock_bh include/linux/spinlock.h:407 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:399 [inline]
 wg_packet_encrypt_worker+0x25c/0x1290 drivers/net/wireguard/send.c:293
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3470
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3551
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 2:
task:kworker/0:2     state:R  running task     stack:0     pid:865   tgid:8=
65   ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7270
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7449
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7473
 __local_bh_enable_ip+0x20c/0x35c kernel/softirq.c:480
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:923 [inline]
 mod_peer_timer+0x21c/0x25c drivers/net/wireguard/timers.c:38
 wg_timers_any_authenticated_packet_traversal+0x98/0xc0 drivers/net/wiregua=
rd/timers.c:218
 wg_packet_create_data_done drivers/net/wireguard/send.c:247 [inline]
 wg_packet_tx_worker+0x130/0x75c drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3470
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3551
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 2:
task:kworker/0:5     state:R  running task     stack:0     pid:4710  tgid:4=
710  ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: wg-kex-wg0 wg_packet_handshake_receive_worker
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7270
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7449
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7473
 __local_bh_enable_ip+0x20c/0x35c kernel/softirq.c:480
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:923 [inline]
 wg_packet_create_data drivers/net/wireguard/send.c:325 [inline]
 wg_packet_send_staged_packets+0xc34/0x1124 drivers/net/wireguard/send.c:38=
8
 wg_packet_send_keepalive+0x144/0x248 drivers/net/wireguard/send.c:239
 wg_receive_handshake_packet drivers/net/wireguard/receive.c:186 [inline]
 wg_packet_handshake_receive_worker+0x5c8/0xcf8 drivers/net/wireguard/recei=
ve.c:213
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3470
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3551
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 2:
task:kworker/0:6     state:R  running task     stack:0     pid:4802  tgid:4=
802  ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: wg-kex-wg1 wg_packet_handshake_receive_worker
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7270
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7449
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7473
 __local_bh_enable_ip+0x20c/0x35c kernel/softirq.c:480
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:923 [inline]
 mod_peer_timer+0x21c/0x25c drivers/net/wireguard/timers.c:38
 wg_timers_session_derived+0x5c/0x6c drivers/net/wireguard/timers.c:208
 wg_packet_send_handshake_response+0x118/0x264 drivers/net/wireguard/send.c=
:98
 wg_receive_handshake_packet drivers/net/wireguard/receive.c:154 [inline]
 wg_packet_handshake_receive_worker+0x570/0xcf8 drivers/net/wireguard/recei=
ve.c:213
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3470
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3551
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 2:
task:kworker/0:0     state:R  running task     stack:0     pid:9     tgid:9=
     ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: wg-kex-wg1 wg_packet_handshake_receive_worker
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7270
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7449
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7473
 __local_bh_enable_ip+0x20c/0x35c kernel/softirq.c:480
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:923 [inline]
 wg_noise_handshake_begin_session+0x698/0x958 drivers/net/wireguard/noise.c=
:856
 wg_packet_send_handshake_response+0x108/0x264 drivers/net/wireguard/send.c=
:96
 wg_receive_handshake_packet drivers/net/wireguard/receive.c:154 [inline]
 wg_packet_handshake_receive_worker+0x570/0xcf8 drivers/net/wireguard/recei=
ve.c:213
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3470
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3551
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 2:
task:kworker/0:3     state:R  running task     stack:0     pid:4306  tgid:4=
306  ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7270
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7449
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7473
 __local_bh_enable_ip+0x20c/0x35c kernel/softirq.c:480
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:923 [inline]
 keep_key_fresh drivers/net/wireguard/send.c:135 [inline]
 wg_packet_create_data_done drivers/net/wireguard/send.c:259 [inline]
 wg_packet_tx_worker+0x6bc/0x75c drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3470
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3551
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
