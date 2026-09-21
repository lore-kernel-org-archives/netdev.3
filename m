Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA787492E5C
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991255; cv=none; b=Aiej44EY+PZf92YhLyzYFrV3G1G9x6RZQcWuM0YW7Ckp3E77zFHz/PUsSSBIA2wg5rJfbDO6ddEdAQXb7JHUv+YXoN8k1SM98Vi9lnuqDCa4wloIKaS7kuhnTBvDcBXxUKghxrXP8+wm3t1399lLF6kpu7QBx2iZ1lKWZX+FuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991255; c=relaxed/simple;
	bh=kVauN+f5NOlRmTdY82forH3vYq9X+Tbj/feWTp1aQx0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=trCPEFLz+AGvQT+zp/PK+Dvcd904ZgCbsUXMmZIuskGcvYb5LxrrjeyPLN4D7grVzKH5dhy3YdMj8QhlQ4U5AGWJshlXz2VgbmNY1oOCmOl7AqoUAG39IZyTAJXaFd+oQjnjTgMdXvyjVG5zrIzyZbZCVevIX1PmIUTJgMBd1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f6.google.com with SMTP id 46e09a7af769-8069d92e182so1242756a34.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 04:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991250; x=1790596050;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :in-reply-to:date:mime-version:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/hXxEHOxrust/MXkf7OZbFEvebD2oys7m23AgyJh5Q=;
        b=rDXUiqHHGMbYcnEe4wsw6mwWZc/Cj7lGLVhvL/rKL7gCddEbSx11lwYmblTwXFS2qi
         qOc0y7Tql+Q1bMX5WKjxOR2CB0EA8kMjGoNTz7AhK38IaflFD9avKCsVaZFvc0omLf0+
         ylE91/1vn9LbPkuflNzWTXK/RMA/vEiSr/K5n8KBCvEgDO0qssuiP+6U4xyL+YMPi3P/
         /dPKrmo5CLMz4x4JgITod9ejQJeiglCTsZNCsG6aVvlihbBxFk6Zv4yeXlxQICVociir
         +C7rkAI+r0cSO2NvUWqj/O+sl3/xOk02xUwhN998uBTwAX1KgY/ZcniUKJWiy5itkwWX
         rQ2w==
X-Forwarded-Encrypted: i=1; AKwUvBzNYw8q3oEhbwhldRfzrzGVHaCxk8glLLzOoHAd5w26NTRddGOtPMz+PkJRAsfBkIior4enetk=@vger.kernel.org
X-Gm-Message-State: AFuF++lvPPUsrPBGIb3kw3fyV29oUghPZuzst7kxk+s+IXvzhpvmf0hE
	rHPAQseAnYwEclBAgMGn7BGTE73dbsQkbO4VwoEhKlWY6oqxsw8ZqwKwhqWnB37EK/oaUKgJsdb
	TYysE02h+iDRV2B3ZMqER6UcQNQHh4izvy6HA95H0a3L28JUVHlPdFOu18MM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a297:10b0:6cd:3fdc:a939 with SMTP id
 006d021491bc7-6cd3fecc5afmr4357428eaf.86.1789991250313; Mon, 21 Sep 2026
 04:47:30 -0700 (PDT)
Date: Mon, 21 Sep 2026 04:47:30 -0700
In-Reply-To: <6aa9b9b7.f81106d8.2ab401.006f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab11952.514bccd6.255447.0012.GAE@google.com>
Subject: Re: [syzbot] [wireguard?] BUG: workqueue lockup in wg_packet_decrypt_worker
From: syzbot <syzbot+d0d2f1a65f45b319d25d@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, jason@zx2c4.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has found a reproducer for the following issue on:

HEAD commit:    38872197cae2 Merge branch 'for-next/fixes' into for-kernelc=
i
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=3D17567005580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D56ed23170c168d4=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd0d2f1a65f45b319d=
25d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-=
1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1606a80558000=
0

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c5963fdd6790/disk-=
38872197.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8c2cab00c45/vmlinux-=
38872197.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bde15d173380/Ima=
ge-38872197.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+d0d2f1a65f45b319d25d@syzkaller.appspotmail.com

BUG: workqueue lockup - pool cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 stuck f=
or 38s!
Showing busy workqueues and worker pools:
workqueue events: flags=3D0x100
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D16 refcnt=3D17
    in-flight: 4858:nsim_fib_event_work for 39s ,4830:nsim_fib_event_work f=
or 40s
    pending: 3*nsim_dev_hwstats_traffic_work, 2*psi_avgs_work, vmstat_sheph=
erd, rht_deferred_worker, free_obj_work, 3*ovs_dp_masks_rebalance, drm_fb_h=
elper_damage_work, 2*nsim_fib_event_work
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D11 refcnt=3D12
    in-flight: 869:nsim_fib_event_work for 44s nsim_fib_event_work ,4806:ns=
im_fib_event_work for 41s nsim_fib_event_work
    pending: psi_avgs_work, 6*ovs_dp_masks_rebalance
workqueue events_unbound: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D22 refcnt=3D23
    in-flight: 1472:cfg80211_wiphy_work for 41s cfg80211_wiphy_work ,1438:c=
fg80211_wiphy_work for 43s cfg80211_wiphy_work ,1295:cfg80211_wiphy_work fo=
r 43s cfg80211_wiphy_work ,14:cfg80211_wiphy_work for 36s ,79:cfg80211_wiph=
y_work for 43s cfg80211_wiphy_work ,1486:cfg80211_wiphy_work for 42s cfg802=
11_wiphy_work ,12:cfg80211_wiphy_work for 39s
    pending: 2*cfg80211_wiphy_work, nsim_dev_trap_report_work, toggle_alloc=
ation_gate, macvlan_process_broadcast, 3*nsim_dev_trap_report_work, flush_m=
emcg_stats_dwork, macvlan_process_broadcast
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D7 refcnt=3D8
    in-flight: 1234:cfg80211_wiphy_work for 43s cfg80211_wiphy_work
    pending: macvlan_process_broadcast, crng_reseed, 3*macvlan_process_broa=
dcast
workqueue events_power_efficient: flags=3D0x82
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D5 refcnt=3D6
    in-flight: 50:neigh_periodic_work for 33s
    pending: neigh_managed_work, fb_flashcursor, wg_ratelimiter_gc_entries,=
 neigh_managed_work
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: neigh_periodic_work, do_cache_clean
workqueue events_dfl_long: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D9 refcnt=3D10
    pending: 9*defense_work_handler
workqueue netns: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D4
    in-flight: 1183:cleanup_net for 45s
workqueue mm_percpu_wq: flags=3D0x108
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: vmstat_update
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: vmstat_update
workqueue mld: flags=3D0x40108
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D73
    pending: mld_ifc_work
    inactive: 2*mld_ifc_work, mld_dad_work, mld_ifc_work, mld_dad_work, mld=
_ifc_work, mld_dad_work, 4*mld_ifc_work, 2*mld_dad_work, mld_ifc_work, mld_=
dad_work, 3*mld_ifc_work, 2*mld_dad_work, 5*mld_ifc_work, mld_dad_work, mld=
_ifc_work, mld_dad_work, 3*mld_ifc_work, 3*mld_dad_work, mld_ifc_work, 2*ml=
d_dad_work, 3*mld_ifc_work, mld_dad_work, 2*mld_ifc_work, mld_dad_work, 6*m=
ld_ifc_work, mld_dad_work, mld_ifc_work, 2*mld_dad_work, 3*mld_ifc_work, 2*=
mld_dad_work, mld_ifc_work, 2*mld_dad_work, mld_ifc_work, 8*mld_dad_work
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D95
    pending: mld_ifc_work
    inactive: mld_ifc_work, mld_dad_work, mld_ifc_work, mld_dad_work, 9*mld=
_ifc_work, 2*mld_dad_work, 6*mld_ifc_work, mld_dad_work, 4*mld_ifc_work, ml=
d_dad_work, 4*mld_ifc_work, 62*mld_dad_work
workqueue ipv6_addrconf: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D178 MAYDAY
    in-flight: 2825(RESCUER):addrconf_dad_work for 0s
    pending: mayday_cursor_func
    inactive: 172*addrconf_dad_work
workqueue bat_events: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D51 MAYDAY
    in-flight: 2857(RESCUER):batadv_tt_purge for 11s
    pending: mayday_cursor_func
    inactive: 4*batadv_tt_purge, batadv_dat_purge, batadv_bla_periodic_work=
, 6*batadv_mcast_mla_update, 5*batadv_iv_send_outstanding_bat_ogm_packet, b=
atadv_dat_purge, batadv_bla_periodic_work, batadv_dat_purge, batadv_bla_per=
iodic_work, batadv_dat_purge, batadv_bla_periodic_work, batadv_dat_purge, b=
atadv_bla_periodic_work, batadv_dat_purge, batadv_bla_periodic_work, 5*bata=
dv_iv_send_outstanding_bat_ogm_packet, 6*batadv_purge_orig, 6*batadv_iv_sen=
d_outstanding_bat_ogm_packet, batadv_tt_purge
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker, wg_packet_decry=
pt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D4 refcnt=3D5
    in-flight: 9:wg_packet_decrypt_worker for 40s wg_packet_decrypt_worker
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker, wg_packet_encry=
pt_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D4 refcnt=3D5
    in-flight: 10:wg_packet_decrypt_worker for 41s wg_packet_decrypt_worker
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg0: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker
workqueue wg-kex-wg1: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    in-flight: 1115:wg_packet_decrypt_worker for 41s wg_packet_decrypt_work=
er
    pending: wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 4356:wg_packet_handshake_receive_worker for 41s
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: 2*wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_tx_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: 2*wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg1: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker
workqueue wg-kex-wg2: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg0: flags=3D0x124
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_receive_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_tx_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker, wg_packet_=
tx_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    in-flight: 40:wg_packet_handshake_send_worker for 6s
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
pool 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D38s workers=3D8 idle:=
 5002 4997
pool 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 hung=3D21s workers=3D7 idle:=
 26 24 4967 5000 4999
pool 8: cpus=3D0-1 flags=3D0x6 nice=3D0 hung=3D0s workers=3D12 manager: 500=
1
Showing backtraces of busy workers in stalled worker pools:
pool 2:
task:kworker/0:1     state:R  running task     stack:0     pid:10    tgid:1=
0    ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: wg-crypt-wg2 wg_packet_decrypt_worker
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7277
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7456
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7480
 __kunmap_atomic include/linux/highmem-internal.h:247 [inline]
 sg_miter_stop+0x220/0x2cc lib/scatterlist.c:941
 chacha20poly1305_crypt_sg_inplace+0x75c/0xc30 lib/crypto/chacha20poly1305.=
c:319
 chacha20poly1305_decrypt_sg_inplace+0x6c/0x94 lib/crypto/chacha20poly1305.=
c:353
 decrypt_packet drivers/net/wireguard/receive.c:278 [inline]
 wg_packet_decrypt_worker+0x490/0xa00 drivers/net/wireguard/receive.c:501
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 2:
task:kworker/0:5     state:R  running task     stack:0     pid:4858  tgid:4=
858  ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: events nsim_fib_event_work
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7277
 __schedule_loop kernel/sched/core.c:7354 [inline]
 schedule+0x13c/0x20c kernel/sched/core.c:7369
 schedule_timeout+0x13c/0x28c kernel/time/sleep_timeout.c:99
 schedule_timeout_uninterruptible+0x78/0xbc kernel/time/sleep_timeout.c:158
 msleep+0x3c/0x68 kernel/time/sleep_timeout.c:318
 nsim_fib6_rt_add drivers/net/netdevsim/fib.c:693 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:759 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event+0x57a0/0x60c4 drivers/net/netdevsim/fib.c:889
 nsim_fib_event_work+0x1d8/0x320 drivers/net/netdevsim/fib.c:1493
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 2:
task:kworker/0:4     state:R  running task     stack:0     pid:4830  tgid:4=
830  ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: events nsim_fib_event_work
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7277
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7456
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7480
 irq_work_queue+0xa0/0xa4 kernel/irq_work.c:125
 __rhashtable_insert_fast include/linux/rhashtable.h:852 [inline]
 rhashtable_insert_fast include/linux/rhashtable.h:886 [inline]
 nsim_fib6_rt_add drivers/net/netdevsim/fib.c:686 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:759 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event+0x4f5c/0x60c4 drivers/net/netdevsim/fib.c:889
 nsim_fib_event_work+0x1d8/0x320 drivers/net/netdevsim/fib.c:1493
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 2:
task:kworker/0:3     state:R  running task     stack:0     pid:4356  tgid:4=
356  ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: wg-kex-wg2 wg_packet_handshake_receive_worker
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7277
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7456
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7480
 __local_bh_enable_ip+0x20c/0x35c kernel/softirq.c:480
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:923 [inline]
 mod_peer_timer+0x21c/0x25c drivers/net/wireguard/timers.c:38
 wg_timers_session_derived+0x5c/0x6c drivers/net/wireguard/timers.c:208
 wg_receive_handshake_packet drivers/net/wireguard/receive.c:178 [inline]
 wg_packet_handshake_receive_worker+0x5b8/0xcf8 drivers/net/wireguard/recei=
ve.c:213
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 2:
task:kworker/0:0     state:R  running task     stack:0     pid:9     tgid:9=
     ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: wg-crypt-wg1 wg_packet_decrypt_worker
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x1370/0x2d80 kernel/sched/core.c:7277
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7456
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7480
 __local_bh_enable_ip+0x20c/0x35c kernel/softirq.c:480
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:237 [inline]
 _raw_spin_unlock_bh+0x3c/0x4c kernel/locking/spinlock.c:245
 spin_unlock_bh include/linux/spinlock.h:407 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:399 [inline]
 wg_packet_decrypt_worker+0x980/0xa00 drivers/net/wireguard/receive.c:499
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
pool 2:


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
