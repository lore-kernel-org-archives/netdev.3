Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824793A7F7E
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 05:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782193087; cv=pass; b=I8E2ZMWFmGblVlbXbS77sopz6iDSSvyIDV5DpdMC+gXkkRzAuVw8xM9s3E2UxsStzKZvVNg74sXEImcM1d3xA2bsnsfdVkYWmsitcVCyRnBfE2zRtGl5UEMLkQctAd7/+yp9lXv2eT4P83tC1HoGTXmgLRMiP62GoUxzYwgVs84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782193087; c=relaxed/simple;
	bh=VWljG9XLveu5P792LTWTSwGwrOfJ/Y/pbZEGuBu9e1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNTwMsDGV27Pyw2T/Kgv5c71E6nqSAbR2CHNU2jQULWA8jMAWWqa/Om5T9f/ZawlcwmUmpF2DlwOyU7mHRj/kC1bdbv+Iof6HdeL4g3zbv+3GatFadLNVl/uh+G2cA2teZcZwIyvDQhKWq2ScFvNO2DyshTCKyD9+dZrqoZtVc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9QSSQqV; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9QSSQqV"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9157b949fc7so524445885a.3
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782193085; cv=none;
        d=google.com; s=arc-20240605;
        b=BukBT1iT0tiWmkGyPSYKETWO0ohnoFgw/RKOvVn96A0D+mea6R3wAOqu1bc9Q+SRwF
         XPeOAc7nez1/AcIlkAvV5cj4cPbGQmjHv1olh4I2fajQhBnXNww3Ifzfut8QTJ2Q+q22
         QRGEX7HnurZx5xsGcOTHVzRnybUx+IXTKx5/r9khpbrxTrlZ4LoanuTw4S/oUR1GVJDC
         /NFYuK++G+1oiCPtBcsGO8JDlMld80ztOF0wU9tRu5cxwjKeZsRnr4UD2qFb4m3tv6Wf
         R/LmLJhH7UwxCaZUF48PTWRcp9g9mUaBFfit7zvRcV2vTtIki2S7vJ3QfQObomoYno7A
         HlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ysOiikk67d0nfdQNdMyo9Uu9CDaFRmos1+EHeJBZSf0=;
        fh=wRX3sGTkS/4nc6mbrqbKWJCUlfC4+e/MgXtGlPYtngI=;
        b=OCleEEJRX++bF9TsVzNhPWxG4HpaHLnDOEkhj7yV/gbFxTWWK2Vsr70E/DesMpJl7S
         5e2qkRNG2PEhCH7Oi5GFtdh2UZZTxB2zp/86vIX/tev7BGdnjcKf4TYOtjA7V7lP+228
         +6glI9audHOd+PeHe3urybzcGlaLSlm3j9nK7niO912jCE0z9VilyTuZ5AF9cxhlHUZr
         XtGv2Fs2h9iR8R6AV8La71M8TkLV2/H+FAWgu2rB9UdYvJOMJMUvOFw3GVyrTp/f51YZ
         4bbScryUZ7fG+9QirCtQK3JdEKk3HBsqaWVoHs9m3oVzEUBEUbeAMG2f1gVmC1RQo7bV
         doXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782193085; x=1782797885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysOiikk67d0nfdQNdMyo9Uu9CDaFRmos1+EHeJBZSf0=;
        b=i9QSSQqVNNLOVNKA9wFoADizJ3062goj7F8pkl7sANyBmNMV+6egTUpQVDliC/Y587
         sXwdoRuhyheO2IY35JE00kmlJwHJWX7cgQRr0VcqVK8uiSO9EHG93GMqn6vHaUDHAjlt
         vzt+uhJSb6ffJ3iBCVFYTADcDOXVjWzJV6u0dsT7JoDD8k2IhxFLX7+RXd39EwT3D1aL
         6UiO0IjyikBCdtb6su04xP6Pnha5Fs9SFZ5BLB8Vy0fsS8r00m4D3Heye6+djvdafJwF
         83UpHUyKm7ffbqxX0hry+evBtBX/VspkZtwHfnslHRaTfP10ZLRg8LxjfxFrgqi8I33g
         B+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782193085; x=1782797885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ysOiikk67d0nfdQNdMyo9Uu9CDaFRmos1+EHeJBZSf0=;
        b=qqHJoqXYEunXtasuwVnEzCO2KyHSA3HSXKu8sZZxX0FQAfbJhA0rXnRcqoADBmzJPw
         fVDi9uzYoHqf+ldwzmE37Um9aIAXEtDKqOxiJVcaZKpPKCyF8MuEGkQ8gtsOaeKs2ep6
         vGRgbyEEThnhURfQQ6N/hvuqoMN1k3pqi+3pTPGUVL9i88AP+AXim61n7z48sGkGEG9/
         qb6fRd3CMqNhnVatu4S9kl5RjIIWyM+a6Rag1PMKXFyq8fepGTEhnGRwZDFfocnG2gnb
         2Us3TtLiqihUwXzokw3zg0JGVQ54Zb+JVAmzlaxf8ojWHAkqA7WUYXwIq5vX1OBuHAMf
         BG4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9gLn3KdNWzP/fZOMtCQ940XkpdbwH7SXoHpUwgQwcbdAh/jEezSlfZmRJQzZEKJsgU6nkuOXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6QuHzk5kB+Yruv77LX3UDO3OrFeIesi3k1J/BBgKnsnC5TLPo
	Dkh+gQWeMV1dpAh2CW7aG0w5DujF1hDS5zYDKswc2GRhm2FP9uNQ1/vcxkvQ3Z4USX5Fj7FfEPG
	Un5AxrIER9ODd0iiH4QtDigqHJNGFKYUWYMxWjdq7
X-Gm-Gg: AfdE7clww7lntqcBB9luyFZ6iHRIDAcQVldGXehmlcr46oZhlw17D9N7AFa9ZqPKKx1
	Kv77HieG0cDuw0Vi8uNZfIgrQ+qDCtUiRZlTU9cKfrF5W3pwD8/oRpswlPVnV2pEAyHD12KlUPh
	Oc7Wp6xrBoidEg5DgjfrIslz6LYoqH5iNa8H854n3nYTDxOwoo+hR+Yp9GT8hB/bCEjY90paltk
	09oxVb+OFKviZKp+bftiHyg+fXPiYnNBgrMEcU68jX0jTi1ARidXTQDEfwS0zkX3e2mSlwHXOcl
	uJPvbdgPdf5cIyb76UE5AS2/rKWs3/FX4rMa7ZwAaPTFTqzrM02JfeWwZktv3vOPLdc6m8+3h4K
	n2zKI2hVQasUtW+zpteM=
X-Received: by 2002:a05:620a:28d0:b0:915:e12d:19ed with SMTP id
 af79cd13be357-921d3da8fe9mr2050998385a.52.1782193084707; Mon, 22 Jun 2026
 22:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622171048.1626022-1-edumazet@google.com> <CADvbK_e_7184a_jm5ASjKafXrJqaOKFUKJF6V1wp7AnFxK596g@mail.gmail.com>
In-Reply-To: <CADvbK_e_7184a_jm5ASjKafXrJqaOKFUKJF6V1wp7AnFxK596g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jun 2026 22:37:51 -0700
X-Gm-Features: AVVi8CeidMQXxuMWfPuny_GiAkuPeb9HWG8ghffbqrtFuGv34sIlzvjhxyoZ4Ik
Message-ID: <CANn89iKFj9vSS6B-=KAMnLyqFqY5edZ-eChfcq+SuGckU6T9yg@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com, 
	Jon Maloy <jon.maloy@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 6:48=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>

> Could this corrupt the list for concurrent RCU readers?
> When list_del_rcu() is called, it intentionally leaves the next pointer
> intact so concurrent readers can continue their traversal. However, the
> immediate call to list_add() overwrites both the next and prev pointers
> to link the entry into private_list.
> If a concurrent reader is currently positioned at rcast, won't it follow
> the newly clobbered next pointer and jump from the original RCU list
> directly into private_list?
> Because private_list is allocated on the local stack, the reader might
> interpret stack memory as a struct udp_replicast. Furthermore, the reader
> would miss its loop termination condition because it expects to reach the
> original list head, potentially resulting in an infinite loop or a crash.
> [ ... ]

I think you are right.

Considering there is already one rcu_head in udp_replicast I will use it in=
 V2.

I will squash/test the following:

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index befaf7137caf642462b7203a2429a60386e64db8..1b1977bd09a3f24028a30c1b98d=
5edc4b1882ba2
100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -803,17 +803,24 @@ static int tipc_udp_enable(struct net *net,
struct tipc_bearer *b,
        return err;
 }

+static void rcast_free_rcu(struct rcu_head *rcu)
+{
+       struct udp_replicast *rcast =3D container_of(rcu, struct
udp_replicast, rcu);
+
+       dst_cache_destroy(&rcast->dst_cache);
+       kfree(rcast);
+}
+
 /* cleanup_bearer - break the socket/bearer association */
 static void cleanup_bearer(struct work_struct *work)
 {
        struct udp_bearer *ub =3D container_of(work, struct udp_bearer, wor=
k);
        struct udp_replicast *rcast, *tmp;
-       LIST_HEAD(private_list);
        struct tipc_net *tn;

        list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
                list_del_rcu(&rcast->list);
-               list_add(&rcast->list, &private_list);
+               call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
        }

        tn =3D tipc_net(sock_net(ub->sk));
@@ -822,11 +829,6 @@ static void cleanup_bearer(struct work_struct *work)

        synchronize_net();

-       list_for_each_entry_safe(rcast, tmp, &private_list, list) {
-               dst_cache_destroy(&rcast->dst_cache);
-               kfree(rcast);
-       }
-
        dst_cache_destroy(&ub->rcast.dst_cache);
        atomic_dec(&tn->wq_count);
        kfree(ub);


Thanks.
