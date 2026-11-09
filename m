Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794266502;
	b=yN1AEOou8veclDFuCVD5mCpaxIbWQ6t3u+c4HcslC0CMfgvvpAQEmj3VSO9o+b48KviC
	 EYf460BKDIDbbiD17B3kjSF4YapefNbAnqExAH/PPS3PuA/VtzwWaxrxCPeS+bd3cAL8y
	 cvcGnqQ4QheCdOuTpBKcocPnyHHO7OgLZsRcfugnhwwLi3LDjmJKiHXlwKgm9rir2g7fV
	 qDHPxp8/3bi6HwKMO+yXFCpGpTs1tP3orBlf9+/zpbX9axAtycKi/E3vgTE7Sf+IMW8oO
	 p3EL4G6tJrZsS/eDiXNneo6tTIGASHVpO+klWASsi9kwuAmaleWCFwa8/w4+gdFG5Ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CDpIx+Do7szWrIbCAcK+KR504Bbm0EqY19tEbj+ilUY=;
	b=bH6gXxiksVAau2VGrwyapogFw9epagtEaVhOG/dwj0Ai/I5FeV+i8hMffJdEIT1rv0G1
	 As0Yx0NMy1b3FNbQ64GUCqgJ21YqU5/drSQE3aUuCRxQQfwE6+JFODSJaHjIoJ4Knd8jC
	 q16IRQ/q9Cf9JxMeuEOizrlgm8nd40X6uxE9AnGradHr1eImWiOKpM9GiFaL52lk0reU5
	 M2DTOFERnB7yFZZNEKR2wT4y/sh4rywSg81YmBQApYVzWcKC1U1YwU1VS2DGHziT1riY5
	 McOzZT1SksHl6aR4hTZIR7DOh3mjyS9uj96zGli1nKRdCoEI1paYETUMoPVw2yUN1Kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=ifjAWogc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0E606A325
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51E0E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=ifjAWogc
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2ccd3c7a2so515205137.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794266500; cv=none;
        d=google.com; s=arc-20260327;
        b=Y483uYRHBrdQ4R9yUZiDsrDrAMWnoOdGCp9MMlUJ8sZnruOqJ60t2qqTlURe+OsUGn
         HOtx6FQ9bMaUkYXp6NU8RfhUWlCm0cSE/M2dWDkOSZ3MEpN4Jm+C8iJuRDluqMFlp5RN
         kuk1nyDho1/l+kAjcEE0aU1CESGhtxMdaSAgOL346UeN1XJUS+DMdhjkWZlEkJXsHsVv
         y8QKxTFcxhAj04vQsevEzBBB4xwy2AonTV7z0ewEM0Tn2JiSbLbagiG2JyZuSQ9exOhw
         K/XSUWHPcgzlkdzzbLssuEtdPkekZfRIPa3+SpJG9OnWIrWTWkQ3FUrsWc9L0FiTJfpe
         Hxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CDpIx+Do7szWrIbCAcK+KR504Bbm0EqY19tEbj+ilUY=;
        fh=C1+s2F6GEbclKE04FgKvIam+3+9j3KhuQbLVWqKLyTc=;
        b=frD1yBkUKQNwof1tzyMZE3KgGY31D7T7sEfbCnUaWsaiK+pSlqF7rlQDbBrbA4anAb
         zEPklNavVBD6+ukqu5k7IKpO8uKe8MeZldjeyFAdGOvxMDGuL60Iykp4Inz4uaJ3/ek4
         7zim5fjaaQ4R/W7XCUUxHskSW9cy3oqIsNDtjMk9maEBqMkxAZzmaTHyTSV6Kv9DPcex
         4LSMMtbW8f/Vy8Mzf9JXvXHM4SedL+7THqNmV634UemojI2AMr2cMH/HYcAvGyq8hN7c
         6l+8OmM/jMgOH9Yn0S28tbwblYEjRUAwOFzx3OKCMjevOIwLCVhNdlksNTg4du7DUklv
         PJ3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794266500; x=1794871300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CDpIx+Do7szWrIbCAcK+KR504Bbm0EqY19tEbj+ilUY=;
        b=ifjAWogcW7pcb98lLVMm8aHBEUHgT8RfxlfaBcTfCW1pNqwVtzSL0NP9VH6Ql/QA49
         JZQ/glolChLo8jRM2JrHttoAKwdXphvMVd4l15WFOpBJ53fy2nvhzS6iNeiaU2V4W/UU
         a7t3mxXnIkTnlJYIN9nLrRj74LKo4LhMP66OpAUHY6kwbUENilSTwBGMtnNapoocq6SD
         72ZM4zdCF8VnhV9T7HBnPMMo/nZxBQxAnhKnG6pM8X34ygmvDllLwRx275d+gYab+N6U
         n3YwCgk8dSQ5K6FtOQoaihXVdxLM4UF+tcsSulLLcM51FFKfZ1hTYaGbgAa/XMtfvAMr
         F37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794266500; x=1794871300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CDpIx+Do7szWrIbCAcK+KR504Bbm0EqY19tEbj+ilUY=;
        b=Dh32fjPz5wQyvxo0hte4u37F8RlR58TDb8/O6xID/ey9+zRfAmiAboE+J7vM9cubGU
         DOJ1oiiC2GJ9MkFCfAQfhaoCvdYGXuFaXtSczZasfedh3+Ntyhy4mgTAi9uE9Emm1buc
         AZ0ecY99lFlCiI7qmD0JdlJNn7pPk6iItJ1TOr0zyW2fYCtdAok8eM+jiXcKDfjaHQpp
         hc+3QRKrVQ6CMRkh/UukeIsLyNdKYaRGYlVYBYlMuL8LHLy4fiajg1R3L5k11jV4tixq
         orxRIeQx+TGE8UpwDhZSZaB8LuYCpftEzN2Odg3LxYDTG6yOBYWm5drFRik+nRyScn9o
         K5tw==
X-Forwarded-Encrypted: i=1; AL+hErEDRirs/2QbOKUPTcC9Hhpi2mZ3XytZYwbXJozUUeM7TRbXKnB3qIP3td1cjkl82pKmAWs5gEE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jYpXXtoQOZzYoS5/ZWruObWlzaJUg+tlJJCKe7KoxXrUjrcWk
	NmJEL9YS4pSK6m8AG8n7pRpbNIVZPYt8B52IReHfWyYvpOnHHQlhBzoLpade6l+fzZYtXJ+HtOf
	qajDSsS27/w+l8QvB4hwtE/ezJjM6R+mVKXp67HBhkA==
X-Gm-Gg: AYBFou08Bs8qqJCVomSz9gv+xUk1tMXzoESUB6c47tZTfXdQaHsE0e2ELUMNBEpkuhK
	IwkRxma/DHu+ryKNCiRjfY0qEM0ym59SILIQZFB9tF/+aTGkKWh5YXhzVcL+GtvrduOioPUXyJU
	P6MLS8dHD7AoyNV6w9W+pzvRiguwiu8xmeVmM8R1BN9pppEdOc8iDjGQCCO4sE81cefuiCNOtrB
	2NNX0/+rbQhx10Gej4dkvgldl6G9QPLBQIE41q9l0Xr7Eu8cSTRvTMrMZ2Jk/jVCTPmfPKzDhUt
	mMAJnLBWMgADtivFIiEKcrLR3dvZi5twwF8ayZTd7z/C3h9WFJxs3Vn1uil8OdRhlonDk93t3KQ
	fyaywAikZ72sIT3FFiBFV4pBzZeVGT1gOC7dGtyfUtr+3IS0Z+kLaDteOkY60QR+maUJgyfB1SI
	lF/Wlz8r1XnJf22NdlJ6vA6qo4H4Zz7456aDOSDVmEKM0dxCVKYe9ApKNSpGdPIe1wbyVRoFLeX
	ZlHVlHynLc7sgiNqiok37A5
X-Received: by 2002:a05:6102:50a0:b0:7cb:bb33:8412 with SMTP id
 ada2fe7eead31-7d301b8e853mr279945137.10.1794266499973; Mon, 09 Nov 2026
 15:21:39 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022181751.1349984-1-rjethwani@purestorage.com>
 <fc0da060-5bf5-4289-8814-d25e6c422673@nvidia.com> <CAKaoeS1hj9XuM7ojLBCjGA=EXc2M-b+eRjC2Sk=8L_8XYeJ18w@mail.gmail.com>
 <4796023b-10ae-4172-afa8-9c7541844314@nvidia.com> <CAKaoeS3hDE5q7XGtPy4XKmGL54-+7Y-H9JyMcdz94FiQW2_ffw@mail.gmail.com>
 <9a8e3e1a-977a-4e48-ba9a-2b71700f6924@nvidia.com>
In-Reply-To: <9a8e3e1a-977a-4e48-ba9a-2b71700f6924@nvidia.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Mon, 9 Nov 2026 15:21:28 -0800
X-Gm-Features: AclHuK8NYfvlY3TxegbK5Jeo9D4vwkdd5lS-bBqcRUhdxsukcZCiSkIWF64ow_o
Message-ID: <CAKaoeS2YkHyrLHwbF0SAE7UtmhknmKEy+16VedDNLt5AMwthZg@mail.gmail.com>
Subject: Re: Question: net/mlx5e kTLS TX TIS reuse vs in-flight WQEs
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 11:45=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
>
> On 06/11/2026 21:58, Rishikesh Jethwani wrote:
>  > Thanks. Agreed on (3a), (i) and the net fixes, with one condition on
>  > (i) below.
>
> Hi Rishikesh,

Hi Tariq,

Thanks. I've now reviewed the seven-patch RFC [1]. The held-skb,
full-resync and pass-through changes cover the points I raised. I've
replied on patches 7 and 4 with two remaining holes in the one-SQ
guarantee: the selection-time ownership transfer, and the PTP SQs in
the drain.

> Thanks. I took your points into the patches, details inline. I'm
> re-running the ConnectX-6 Dx tests with the changes, and will share the
> RFCs once they pass.
>
>  > Thanks. Until then, the two hardware questions remain open, including
>  > whether DESTROY_SQ can fail; the destroy wrapper discards the status.
>
> DESTROY_SQ doesn't fail while the function is healthy. If it does,
> something went badly wrong in the firmware.

Thanks for clarifying the healthy-function case. I'll continue to use
CQEs or successful SQ destruction as the retirement evidence.

The DEK question is still open: once all old-key WQEs have retired, may
the old DEK be destroyed or returned for reuse while an idle TIS still
names it? This needs to cover both standalone DEKs and pooled IDs reused
by another connection. A flushed replacement need not have installed
the new key, and deletion can return the still-bound TIS to its pool.
The resync fix restores the context on its next use, but does not by
itself establish that releasing the old DEK before then is safe.

Please keep that HW/FW answer explicit. Until it is settled, I cannot
treat a flush/close alone as sufficient to release a still-named DEK;
the conservative alternative is to retain the possible bindings until
a successful replacement or TIS destruction, including through pooling.

>  > One correction to my last mail: recovery clears RECOVERING even on a
>  > flush timeout, so the queue can wake once stop_room frees.
>
> Thanks. WQEs posted to that SQ then complete with error CQEs, which mark
> their connections for a full resync, as in the first error.
>
>  > Agreed. What rekey needs from that resync fix: a lost initialization
>  > or replacement always triggers a full resync on the next skb that
>  > needs the TLS context, and a connection marked again while the driver
>  > is consuming an earlier mark stays marked (test-and-clear, not
>  > clear-after).
>
> Both hold now. The mark stays until an skb that uses the context
> consumes it, and it is taken with a test-and-clear before the resync is
> posted, so a loss reported meanwhile marks the connection again.
>
>  > An explicit bypass right after the
>  > datalen check in mlx5e_ktls_handle_tx_skb() closes that without a
>  > sequence comparison:
>  >
>  >         if (!skb_is_decrypted(skb))
>  >                 return true;
>
> Agreed, it's in the pass-through patch, with credit.
>
>  > I'm happy to use (i), but warning/counting alone does not cover the
>  > forced-queue case: a detected conflict has to prevent the conflicting
>  > hardware access, since old TIS accesses must have retired before
>  > another SQ can modify the context. Dropping before any TLS WQE or
>  > context-state change would preserve safety without SW crypto.
>
> Agreed, the counter is now a drop. Each connection records the TX queue
> that it posts on. An skb on another TX queue moves the connection only
> if no other skb of its socket is in flight: an skb is freed only once
> the WQEs posted for it completed, or were destroyed with their SQ, so
> nothing of the connection is then pending on any SQ. Otherwise the skb
> is dropped before anything is posted, and counted, and TCP retransmits
> it.
>
> The move is made under the old TX queue's lock, taken with a trylock,
> under which the connection posts there. That serializes the check and
> the publication with that path, and leaves the connection's datapath
> with a compare of the queue index.
>
> This covers your points 1 and 2 where the WQEs are posted, wherever the
> queue came from. For 2, the mlx5e pin now also re-checks wmem at
> selection as you suggest, so a stale ooo_okay doesn't lead to drops in
> the first place. Does that match what you had in mind?
>
>  > 3. The drain has to cover the QoS/HTB SQs too, and reap deactivated
>  >    SQs although mlx5e_poll_tx_cq() returns early once ENABLED is
>  >    clear; a missing or replaced txq2sq entry isn't evidence of
>  >    retirement. On a drain timeout, the fallback must close the old
>  >    SQs first (which keeps the guarantee, modulo DESTROY_SQ), never
>  >    activate with them alive.
>
> That's how the drain works: it covers the QoS SQs, reaps the deactivated
> SQs directly, and on a timeout closes the old channels before activating
> the new ones. The drop above doesn't rely on txq2sq either: an SQ that
> is deactivated alone, e.g. on an HTB leaf delete, keeps its skbs until
> it is destroyed, so their socket keeps its wmem until then.
>
>  > On the price you mention for priority changes, agreed. Please
>  > document in Documentation/networking/tls-offload.rst that pinning
>  > delays priority/DSCP/HTB-driven TX queue changes until migration is
>  > safe, potentially indefinitely under sustained traffic.
>
> Done.
>
>  > Nice, that's simpler. On the core side, the op's contract: the
>  > callback prepares the new key and pending parameters but posts no TLS
>  > WQEs for this connection.
>
> [...]
>
>  > Callbacks are serialized per connection, but another may arrive
>  > before the previous replacement is posted. On success, the driver
>  > must clean up any superseded, never-posted key.
>
> Agreed on the contract.

Agreed. I'll replace v18's live TX del+add with the new callback and
implement mlx5e_ktls_rekey_tx() on the revised fixes. That includes
cleanup of superseded, never-posted keys, and explicit ownership of
retiring DEKs through WQE completion and deferred destruction. Devices
without the callback will stay in software after a KeyUpdate.

The delayed decrypted-clone case remains a separate core follow-up.
The pass-through bypass closes the unmarked-skb case, but the existing
32-bit record lookup can still alias a later record, even without
rekey. Rekey adds the cross-key case; the floor only covers delays
within its comparison window. The fix I'm considering needs TCP
support and a per-skb check in the driver's in-order TX path too; I'll
Cc you when I post it.

>  > Record lookup also uses 32-bit TCP sequence numbers
>  > today without rekey, so a sufficiently delayed clone can alias a live
>  > record there too. The floor catches old-key clones within its
>  > comparison window, but does not remove that ambiguity. I'll look at
>  > closing this in the core separately.
>
> Thanks. On the driver side, the bypass above keeps plaintext skbs out of
> the record lookup, so it's down to the decrypted clones.
>
>  > Please Cc me on the RFCs, and let me know which fixes the rekey
>  > patches should depend on.
>
> Will do. The rekey patches should go on top of these net fixes:
>
>    net/mlx5e: kTLS, Hold a dropped skb until its posted WQEs complete
>    net/mlx5e: kTLS, Resync TX fully after its WQEs were lost
>    net/mlx5e: kTLS, Post TX context params only for skbs that use them
>    net/mlx5e: Drain old TX SQs before activating new channels
>    net: tls: keep the TX queue of a device-offloaded socket stable
>    net/mlx5e: kTLS, Keep the TX queue of an offloaded socket stable
>
> The drop goes to net-next separately, as "net/mlx5e: kTLS, Keep a TX
> connection on one SQ at a time"; the rekey patches don't depend on it.

I do need patch 7, with the selection-time fix from my reply to it, as
a rekey dependency. Patches 1-6 alone do not cover egress skbedit or a
cached queue overwritten by another device on the route. A fenced
replacement on SQ B cannot order itself against old-key WQEs still on
SQ A. Keeping patch 7 in net-next is fine; I'll base rekey on it as
well as the net fixes. The RFC cover letter's "builds on this series"
matches that dependency.

> Thanks,
> Tariq

Thanks,
Rishikesh

[1] https://lore.kernel.org/netdev/20261109114734.2087878-1-tariqt@nvidia.c=
om/
