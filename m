Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3FB4C33F0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156582; cv=pass; b=rhZtxJypliY+rb1aYedtQC9NqifwCj5W0EYeO82C3JGAaBh0IxFuv7Pv9EgbhN+5JxWJz7aWsYVJFqpPtCAuS638xwM9kN8iz0vgl7ek9c1Jxa6M0iFQfFCwD5GiV4mbSOX01j1FjmXW2mWYM6ua+ZCV8JI6VjR7cE5x/3Y6Rvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156582; c=relaxed/simple;
	bh=WxKFwcJVOeUaFHQx1ghUjglbbmu9mBiG4gBTht9gmmw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rUoiZcb0XrF0FB7Le9e1Bj+gS3tTl1r6yeVrm9oGhcUtdwjWQBuofNnPotY2fxNvx9zRgaYE1G/I3plEMwRWSMQhkHgcNYmu2n67v4tiwOFy+A4qKsfOySsuSVG8LY/bEyxE5f0qvyObmbLpqyOYnIg124CW3PuHyJSwH6xhraQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia16J9S6; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia16J9S6"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ea7137b147so65981e0c.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792156579; cv=none;
        d=google.com; s=arc-20260327;
        b=LgiKRGF7srahRCV+5iWZeKqLTyQv0m6LH6LTyazMtAWvJbdqUF/OMpDeq3n8zDhSkD
         5gPD8CgHBukw7zCoUJ5SHB5VsRNApQ82BM6XJmC/+MBzcW0+p1k1BzPRmV3DtWx8QLNd
         Jwnia7gO16jJqo0Rzpg0lvY2ozx4JezY9p6MNXup/rpshKg6+5ysGrsmGkBIuihD/dtg
         TN8cKE25AFfC8US+4r2KxpnPiSZpRRtpBZlb3cXKTzctAgEfrZWRhFaa11CFiCGVZk+v
         RH3WzSi9PfQBeoytV2FQakBq0Q3tjt3B0fagaYOqA+8kyHqXFyjOig1k2v69WNXXY+J2
         S1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=m34V2DPSJQMgJ0PsxVie6y4fZxdO2kQHq0+ZE0ltKgQ=;
        fh=hjnyWgENE+pnBT/rwySrzUaRIEDZDpLOCmbWyXmJTCA=;
        b=HzCMPP5g5gF/q//Vorclkyu4yojPHDSrc3g0SlxboUD6NwTBR7Ivi1TJlguTvvkqQ6
         Z+dy7h9/JqRhehwDf9bc3TaDYBr8FrauxsFP9JRjw013fanIS1D7TpQ4PUDZAUEW+0+5
         5EPg4EQ9MUS1Nals6tfo8z2QcTyfDHINu7A2vNgqIacoJgA96E1LyOlL4JbkJlvLrMls
         v+eJvKGrBzUgGQAAMnfuxXwlaIqdrqterQdoOX1GRUmQZzD2rFiDYIpPmtuutSwZcvP7
         BZEHdDAvP/hyFHvJ4fnlHgSXG9EAD6MVvEOO6b6ZguVpxTH2X8OXOL6Vxc+gJxCNVsJu
         fxHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792156579; x=1792761379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m34V2DPSJQMgJ0PsxVie6y4fZxdO2kQHq0+ZE0ltKgQ=;
        b=Ia16J9S6fkXDxuyv039Zr7xALZiHFeXi51ANUxZKwtwrI0chmKm0d7xkW4WWMxweeP
         9n+OVNoQ78iirKGiMawIWirs5s94HMe0RsEyVpX3jqwbkLs8edfmkZb/NZwWvB8HFHfd
         xERY94YDwuRh5UaUAs4GQyNGpX+RgqRo6nTfx9TfHoOF2KAnpaws1mqh3U+2c4S9CWYO
         fHil0J9LXa2ZF6UMUINbr/l6kKRy4++gaAn/DACKgyEMBxSb6wrbbXI+enrOJC3uJQjA
         WIS77tcUf3nLs4AQY4GqroE32Hjl1mtykh1YfU3mhbv5a9Hss2gkUl5Es8x44nwgcATe
         vxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156579; x=1792761379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m34V2DPSJQMgJ0PsxVie6y4fZxdO2kQHq0+ZE0ltKgQ=;
        b=pIk1EI7Tfj1rS9xUqeu6XT3EKwZrIIyf9vEjov/0vlqLu5SIWBoThNkwNtwY0dbi/9
         RrTSBu+xZa3w6YKSUbqqSi4lehYEfuW/KtBbbDwUn4pvYlz1h5nVxlEppKGNpIrhkjJ3
         YUNU+0b7nB1J03EDzWeucJCm3pcU3z88SMfV0zfxOSWiqOUsP/Vpvw49Rn0Vn3r4nbDM
         qk0FSDtMyE/L4BwFjYSCsSiK2W8WEUJy2hevsi0HMIlldFpNXSicq49/XcscjgDeGOHL
         68U6nQjW4L2hTW9GKTt0Y/iwqBOVoYVdhJOJi2p9c0Bdq9PaNYulgGsgtCbnvYNmbOUO
         sqGA==
X-Gm-Message-State: AFq9FYJk2ZKHRjhdA2rD64l9XzP1q8ApsmpavnW/SjoEUZfCum08SAdn
	xEWSYvvLZa+5vJpNJSGHWGHRTn13YoXOr22HJYoTwmj/bK3au+ohPPYsM/dAPbuKfUToLYfCsvq
	K1RODh7/S9vZtnCTE2Sz8rASzRWXa6/THLlMWu0bmbw==
X-Gm-Gg: AYBFou0Pi9sa0L8vB9AazFmDkAs8VNo3+KoG+fXw/WdzqQB5FAHq1W43GpF19QWWmjj
	R0sExIE+xeb+R39TLWhix7vdjvipiVfXfHbck1Ku+XexeJ/4YfljGEGCW5WYSKrk2jHC566oMc7
	cCFNFpn5FHEuu1FdvOvFps0FgM1a7v943dISa0a9VXt43cDS1SscAb3dzHBiDiP3igUC+vWppFA
	ee85TbIlnBerLZrehCkQFLrfEkTrRjnPKxBPZCAbz0HGKnDBNhO/eBqh7urzTYBNst2WrJt56Bd
	5OxfF2/FdQrFb0hsPFY7uDtU08M/E+AvPskN6VUKEkDgI9NMBNz2/VsDzdD0T6D+OkaOJnf0WbP
	M5rDsUldYXW9tA8K6ERGH9moXNoLFuXSX5xhN9liMvw==
X-Received: by 2002:a05:6122:8704:b0:5e9:397d:b197 with SMTP id
 71dfb90a1353d-5e9397db6b5mr5174161e0c.3.1792156578871; Fri, 16 Oct 2026
 06:16:18 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 08:16:17 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 16 Oct 2026 08:16:17 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Fri, 16 Oct 2026 08:16:17 -0500
X-Gm-Features: AclHuK8xJbV9fsv1Ej8XzXPH6zX3IbQC6Zj0JpmjQur27sv77M0ATC1K6PdxLXU
Message-ID: <CABKbRoJw5SOQH6ydjxyi9j4k2uhjnDSwN2dOpzCAGsFeJZ0bJw@mail.gmail.com>
Subject: [PATCH net v3] llc: shut down timers before dropping SAP and device references
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot reports a slab-use-after-free in
llc_conn_ac_send_sabme_cmd_p_set_x() when a connection timer dereferences
its SAP after the last socket reference has been dropped.

llc_ui_release() holds an extra SAP reference for release_sock(), but
drops it before llc_sk_free() stops the connection timers. If this was
the last socket using the SAP, llc_sap_close() can RCU-free it while a
timer callback is still running.

Keep the extra SAP reference until llc_sk_free() has completed. Use
timer_shutdown_sync() for final teardown: a fixed-order pass with
timer_delete_sync() permits a callback or concurrent state-machine
action to rearm an earlier timer. Keep the device reference through
timer shutdown and queue purge as well, since timer actions can use
llc->dev. The non-final timer stop path retains timer_delete().

Fixes: 9708d2b5b7c6 ("llc: avoid blocking in llc_sap_close()")
Reported-by: syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D44efda9647c52be29d9c
Signed-off-by: Miguel Garc=C3=ADa Rom=C3=A1n <miguelgarciaroman8@gmail.com>

---
v3:
  - Keep SAP and device references until after final timer shutdown.
  - Use timer_shutdown_sync() to prevent cross-timer rearming.
  - Remove the separate unlocked timer stop from llc_ui_release().
  - Reproduced the KASAN report on the unpatched kernel; the patched
    kernel completed five reproducer runs without a KASAN report.
  - syzbot reproduced the UAF on the unpatched control. Two patched
    jobs built successfully, but their C reproducer aborted at bind()
    with EBUSY, so no Tested-by tag is included.
v2: https://lore.kernel.org/netdev/20260916104735.3565609-1-miguelgarciarom=
an8@gmail.com/
v1: https://lore.kernel.org/netdev/20260916074158.3375909-1-miguelgarciarom=
an8@gmail.com/

 net/llc/af_llc.c   | 11 +++++------
 net/llc/llc_conn.c |  9 +++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index b0447c33d..e34d1e7b5 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -196,6 +196,7 @@ static int llc_ui_release(struct socket *sock)
 {
 	struct sock *sk =3D sock->sk;
 	struct llc_sock *llc;
+	struct llc_sap *sap =3D NULL;

 	if (unlikely(sk =3D=3D NULL))
 		goto out;
@@ -207,23 +208,21 @@ static int llc_ui_release(struct socket *sock)
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
 	if (!sock_flag(sk, SOCK_ZAPPED)) {
-		struct llc_sap *sap =3D llc->sap;
+		sap =3D llc->sap;

-		/* Hold this for release_sock(), so that llc_backlog_rcv()
-		 * could still use it.
-		 */
+		/* Keep SAP alive through backlog processing and timer shutdown. */
 		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
 		release_sock(sk);
-		llc_sap_put(sap);
 	} else {
 		release_sock(sk);
 	}
-	netdev_put(llc->dev, &llc->dev_tracker);
 	sock_put(sk);
 	sock_orphan(sk);
 	sock->sk =3D NULL;
 	llc_sk_free(sk);
+	if (sap)
+		llc_sap_put(sap);
 out:
 	return 0;
 }
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50..2ad5a69dd 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -942,10 +942,10 @@ void llc_sk_stop_all_timers(struct sock *sk, bool syn=
c)
 	struct llc_sock *llc =3D llc_sk(sk);

 	if (sync) {
-		timer_delete_sync(&llc->pf_cycle_timer.timer);
-		timer_delete_sync(&llc->ack_timer.timer);
-		timer_delete_sync(&llc->rej_sent_timer.timer);
-		timer_delete_sync(&llc->busy_state_timer.timer);
+		timer_shutdown_sync(&llc->pf_cycle_timer.timer);
+		timer_shutdown_sync(&llc->ack_timer.timer);
+		timer_shutdown_sync(&llc->rej_sent_timer.timer);
+		timer_shutdown_sync(&llc->busy_state_timer.timer);
 	} else {
 		timer_delete(&llc->pf_cycle_timer.timer);
 		timer_delete(&llc->ack_timer.timer);
@@ -978,6 +978,7 @@ void llc_sk_free(struct sock *sk)
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 	skb_queue_purge(&llc->pdu_unack_q);
+	netdev_put(llc->dev, &llc->dev_tracker);
 #ifdef LLC_REFCNT_DEBUG
 	if (refcount_read(&sk->sk_refcnt) !=3D 1) {
 		printk(KERN_DEBUG "Destruction of LLC sock %p delayed in %s, cnt=3D%d\n"=
,
--=20
2.43.0
