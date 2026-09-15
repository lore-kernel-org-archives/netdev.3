Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EC3F4118
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508027; cv=none; b=JqMs5L3ch1NU469jeWWg398wIKQZYuLxoYCG0ansCQtgm8cNWulwq8nbj4CK62eLzPVpVkeDzxc1CeTS6ePpl9jlDmouxS6UrqWl47xtc/DnxxyvzaISD7a+Fg8JeOpM+WdhrGk0pXZRThQ2WNaGZZ2FltpTgGUuh7BmbKzX0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508027; c=relaxed/simple;
	bh=rJy1/4VAIH6j4bH3PhEclO04Ip7pqku0TrNVjMjmLzs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lpIix+XHdDMDVTmkHPfh3yq86vlQQN5d9zwwCY2n8xzsHIFtT28DbUk8DbUvXdds9icMBMqBgyUAkZcn0IIJgTlL2Os8yHL54I2z7sX2C2Vs/Vfb3cD6/0nGDiytP3IePADL2Ue4/Kajj+71eMi4iq6f4t1hci2WgEqmYEP4e9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a4492f5cd1so825677b6e.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508023; x=1790112823;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2sS1ijsvVV0SDkEUN/Ki5tflNB8j3+HYujKSndllF1k=;
        b=L3pOeTGtdGHUbWK6xfVtintRJtucmklNNlFYmM5ZdAZNPLrZhiOWbqgCsku5/mvCdE
         fr0/V5oUlRVGmCKxdkz93wiwxahQ3yH/nT6QJ9VU90SoRo77eXKT0Ln+rH4wYC0T0s2D
         hBJlTs+w9HS/zA9g5OOjS7VLT6r19ipLgT9N63LjuOflo8nMGE/W1jndZGCuIl6i2vD6
         FuMeVQjuNouRjbArK8mMdRzSBZm6nh3ifP1Yc8i6Gbp4qmwd0/R80TuDSEzvdhzcnlix
         MWzC7uHjHClHGr+v5+EFVKjQPRSIgJguG2uPXb69bmlHbmXYNCRYO/CJj3TN/0EHjIAI
         gAGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVz+AcrJOx6Sijw7nVlEEyi2mMKzYvsmXWKZ5/vGmj+k1UvBFV7RkDGldO8GwXy8zpvjN5w3A=@vger.kernel.org
X-Gm-Message-State: AFuF++kdIHLmk+j5AEHAWIw4NkK3U72u2QFjTkk8um2B1B7tHR4UtaBD
	TY00m4S3DUgZT038d/LC84fMIWokrjtpG8PzzAQWrXh9oM+dWPOgrfDjiVbmRMchXx9G48qVg/y
	y8lxl5gdKVAkjhXmICYvdQW48fOT1Tyk2J2svI71N4vEHV6JW0PROir4U+gw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1409:b0:4c3:ebb:6405 with SMTP id
 5614622812f47-4ca4c282440mr226899b6e.32.1789508023539; Tue, 15 Sep 2026
 14:33:43 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:33:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa9b9b7.f81106d8.2ab401.006f.GAE@google.com>
Subject: [syzbot] [wireguard?] BUG: workqueue lockup in wg_packet_decrypt_worker
From: syzbot <syzbot+d0d2f1a65f45b319d25d@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    5445d6419962 arm64: Don't read GMID_EL1 when MTE is disable=
d
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1114c2d1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D56ed23170c168d4=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd0d2f1a65f45b319d=
25d
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
Reported-by: syzbot+d0d2f1a65f45b319d25d@syzkaller.appspotmail.com

BUG: workqueue lockup - pool cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 stuck f=
or 45s!
Showing busy workqueues and worker pools:
workqueue events: flags=3D0x100
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D6 refcnt=3D7
    pending: vmstat_shepherd, 2*psi_avgs_work, 3*ovs_dp_masks_rebalance
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D18 refcnt=3D19
    pending: 2*psi_avgs_work, 3*ovs_dp_masks_rebalance, xfrm_state_gc_task,=
 psi_avgs_work, delayed_vfree_work, 8*nsim_dev_hwstats_traffic_work, psi_av=
gs_work, free_obj_work
workqueue events_unbound: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D20 refcnt=3D21
    in-flight: 3055:cfg80211_wiphy_work for 75s cfg80211_wiphy_work ,54:nsi=
m_dev_trap_report_work for 6s ,431:cfg80211_wiphy_work for 73s cfg80211_wip=
hy_work ,348:cfg80211_wiphy_work for 91s cfg80211_wiphy_work ,1617:cfg80211=
_wiphy_work for 76s cfg80211_wiphy_work ,12:cfg80211_wiphy_work for 93s cfg=
80211_wiphy_work ,1777:nsim_dev_trap_report_work for 11s ,40:cfg80211_wiphy=
_work for 92s cfg80211_wiphy_work ,3203:nsim_dev_trap_report_work for 1s
    pending: nsim_dev_trap_report_work, toggle_allocation_gate, 2*nsim_dev_=
trap_report_work, cfg80211_wiphy_work
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D7 refcnt=3D8
    in-flight: 13:linkwatch_event for 95s ,3020:cfg80211_wiphy_work for 89s=
 cfg80211_wiphy_work ,3157:cfg80211_wiphy_work for 60s cfg80211_wiphy_work
    pending: 2*nsim_dev_trap_report_work
workqueue events_power_efficient: flags=3D0x82
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D6 refcnt=3D7
    in-flight: 1756:neigh_periodic_work for 6s ,284:reg_check_chans_work fo=
r 75s
    pending: neigh_periodic_work, wg_ratelimiter_gc_entries, 2*neigh_manage=
d_work
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: gc_worker
workqueue events_dfl_long: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D6 refcnt=3D7
    pending: 6*defense_work_handler
workqueue mm_percpu_wq: flags=3D0x108
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: vmstat_update
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: vmstat_update
workqueue ipv6_addrconf: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D9
    in-flight: 59:addrconf_verify_work for 78s
    inactive: 5*addrconf_verify_work
workqueue bat_events: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D45 MAYDAY
    in-flight: 2855(RESCUER):batadv_tt_purge for 18s
    inactive: batadv_tt_purge, batadv_mcast_mla_update, batadv_tt_purge, ba=
tadv_dat_purge, batadv_bla_periodic_work, batadv_dat_purge, 2*batadv_bla_pe=
riodic_work, batadv_dat_purge, batadv_mcast_mla_update, batadv_bla_periodic=
_work, batadv_dat_purge, 2*batadv_mcast_mla_update, 2*batadv_iv_send_outsta=
nding_bat_ogm_packet, batadv_purge_orig, 3*batadv_iv_send_outstanding_bat_o=
gm_packet, 2*batadv_purge_orig, 5*batadv_iv_send_outstanding_bat_ogm_packet=
, batadv_purge_orig, batadv_iv_send_outstanding_bat_ogm_packet, batadv_mcas=
t_mla_update, 4*batadv_iv_send_outstanding_bat_ogm_packet, batadv_purge_ori=
g, batadv_bla_periodic_work, batadv_dat_purge, 2*batadv_tt_purge
workqueue wg-kex-wg0: flags=3D0x124
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
workqueue wg-kex-wg1: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    in-flight: 10:wg_packet_handshake_receive_worker for 46s
    pending: wg_packet_handshake_receive_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker, wg_packet_decry=
pt_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 3495:wg_packet_handshake_send_worker for 4s
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 4477:wg_packet_handshake_receive_worker for 12s
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: 2*wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_decrypt_worker, wg_packet_=
tx_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 9:wg_packet_handshake_receive_worker for 20s
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D4 refcnt=3D5
    in-flight: 4889:wg_packet_decrypt_worker for 45s
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker, wg_packet_decry=
pt_worker
workqueue hci0: flags=3D0x20012
  pwq 9: cpus=3D0-1 node=3D0 flags=3D0x4 nice=3D-20 active=3D1 refcnt=3D4
    in-flight: 4723:hci_cmd_sync_work for 84s
workqueue wg-kex-wg0: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    in-flight: 24:wg_packet_tx_worker for 45s
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
workqueue wg-kex-wg1: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 4799:wg_packet_handshake_receive_worker for 17s
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker, wg_packet_decry=
pt_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: 2*wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker, wg_packet_=
tx_worker
workqueue hci3: flags=3D0x20012
  pwq 9: cpus=3D0-1 node=3D0 flags=3D0x4 nice=3D-20 active=3D1 refcnt=3D4
    in-flight: 4726:hci_cmd_sync_work for 78s
workqueue wg-kex-wg0: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 4840:wg_packet_handshake_receive_worker for 11s
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg1: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 4806:wg_packet_handshake_receive_worker for 19s
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker, wg_packet_decry=
pt_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 4827:wg_packet_handshake_receive_worker for 6s
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_decrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker, wg_packet_=
tx_worker
workqueue wg-kex-wg0: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker, wg_packet_decry=
pt_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 1159:wg_packet_handshake_receive_worker for 23s
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_tx_worker, wg_packet_decrypt_worker, wg_packet_encry=
pt_worker
pool 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D6s workers=3D10 idle:=
 4820 4807
pool 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 hung=3D45s workers=3D8 idle:=
 5732 5459 26 4798 868 5730
pool 8: cpus=3D0-1 flags=3D0x6 nice=3D0 hung=3D1s workers=3D17 manager: 652=
9
pool 9: cpus=3D0-1 node=3D0 flags=3D0x4 nice=3D-20 hung=3D0s workers=3D8 id=
le: 4721 4713 4718 4717 50 4720
Showing backtraces of busy workers in stalled worker pools:
pool 6:
task:kworker/1:4     state:R  running task     stack:0     pid:4889  tgid:4=
889  ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: wg-crypt-wg2 wg_packet_decrypt_worker
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7270
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7449
 preempt_schedule kernel/sched/core.c:7473 [inline]
 class_preempt_destructor include/linux/preempt.h:500 [inline]
 try_to_wake_up+0x5f8/0xdc4 kernel/sched/core.c:4432
 wake_up_process+0x18/0x24 kernel/sched/core.c:4557
 process_one_work kernel/workqueue.c:3355 [inline]
 process_scheduled_works+0x744/0x1250 kernel/workqueue.c:3470
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3551
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 6:
task:kworker/1:0     state:R  running task     stack:0     pid:24    tgid:2=
4    ppid:2      task_flags:0x4208060 flags:0x00000010
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
 wg_packet_tx_worker+0x520/0x75c drivers/net/wireguard/send.c:276
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
