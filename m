Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6733A6F7
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665392; cv=pass; b=u7cDXPL85SuZsgUNZYXPKxn2zPuxjDIWsaNwWiUHCru5OUTvirhD8cwVP9L2EG/t3VMaEjz05vUx97G8zEoyQWHN4w+VlTyHmhWmmGGnrII+i/Iau71/U2bGnIvF3NenZX9Twfz0opnwTGGQCi8Ff0GRJo3b5x7j2U2b4S8ifCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665392; c=relaxed/simple;
	bh=C1iC81hsjhmQUxLq/1lUBia0ESHJlxC8Sw3i6Bble+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2/QXVSTmXQy/ahh+VVQ6J2FlQhqQxwC2q8K9Tm9GHyOw0JhMGJ4DMUCKUmav2c7WV01lsr5gftv3DrOOYt9eJDZlYXlOJJoGauPzLkD8sHGvwg4B7HnyBs7KPf3BH0J813tv+lqWrI/PuI8kIBeCScClHsR5mir/3qYtGutzzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtz0O+bx; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtz0O+bx"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f186025973so45582486d6.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 06:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665390; cv=none;
        d=google.com; s=arc-20260327;
        b=DQl7CarUox+SmcHzBwPLq7BxMDfOSYo3iLp/EgkYaX79+wxXYkvwyfKc49JMilmJK/
         iGt5rOy8YeaSffokCDHqRisoaIRhfbLTW/8d3D8cBi8y0E5XykcuLQ/7jYY5DYmfUuc3
         x4RJkMkZlTa718TkoZX4IUDcQ0GuE+wd+og/bAI0/gDP+oOFiXm33syTB4ut5euKiX6W
         yFGZOEUkUoY36Qa1lb/wh8StV4a8qPzXTgz0vT/3sMdCrlzIr9tZLOzLGYXLBbJ04vED
         fOydfGyWpSlti7/UhzhJOivbw0ccwwgrqRkIsBZlVcEC2u4NOSa82JCNFWa9/Ow8ZQHj
         r35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JWDAzYZFEkZgn9JQSwJnfdgSRZDMe0Wi+uaB7qB4Hcs=;
        fh=r30K7udsA/iOTZSV42YjBYWqXGpK7rISk6myshXZSOc=;
        b=E8O6oQLebaW65s6vHIygtmrSoHLA4cIDqRzS8bs+e7eVc7EsItAnfuvmNm3QqDdh0/
         SOpHxPfg04xhrgu3tE6ZqMFNd6jUHOBuegtKmLK/JcAWWjWhLXaxZK267QSHq/qbvgvu
         94ME7IUEvrQbm1MArRBJ3hoUl+uyY9adeBhI8xK58wlE1XePTNjjnJRRuX6UpaE/unEK
         /gTeGyQRm6B9/0thmLL4ro+62jlXhctRTL0ccx8XAK37WiYQXbWuBPETshnbys7Btw+p
         Pm3DKQg+b8hhYX+osd4lg9eq/QkP0yIX/yL5DP3nKT/xgpSCSbnQDq0AXA77PJ0mZn3i
         mvjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787665390; x=1788270190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JWDAzYZFEkZgn9JQSwJnfdgSRZDMe0Wi+uaB7qB4Hcs=;
        b=jtz0O+bxi0ZsJ6YCHJcYumouCAB8orwfw/a/RJ8Sa2O55YipjtYK6CMcGmHBncsNEY
         FyWwE2Vz58E7Kn75S8PIwevVTftw35RmiQbBy80Oz6ckPfBPT+7GWU+FDMGRviKI6TNh
         iLZWJFfttHvrocuN9ZJOahWnwtSszlBBB1rTeg8x26UwaeXVUw0xr7Kgyg2GnGzhpgp9
         B92Jre12G/+9UTIoP4UZIWJ8enSikUtwXfdafGOCgdXP8zKLjeIylV09ULnOBkvYM6Ah
         YD3BKVdnuOzWwf6NvzJ36cI/VAxN791tuURU1909D1DnJhIYRT5Q4ptYQ14VnlWGbpX7
         T3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665390; x=1788270190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWDAzYZFEkZgn9JQSwJnfdgSRZDMe0Wi+uaB7qB4Hcs=;
        b=DVBbsMB6MTwdJTykfvWfm2gHEHkA+k9f46+d2S2LfatjkfMKBuFTOPlYIcRR9DDkVL
         MUfu2gC8m0fji322d4wR80lC4zkcFEqgYyPy2apyOGq9CnDU6v/M8vK9nloKDR2lj3Dd
         f1FuSDkrwC+GRZTPm7pCsfD71NN6lfnwdRO6Dn08hKS5OLgq51UtMwmjY8p79oVo+qt/
         Mb7+nnuUgOxODPCCvRb/MihCDM4kfVv44dYaQZLWqsxB3D2kl7bqaHz1eoP37ttO5X6B
         wMink8y6vT6pUv5jLKKdfA3ljdq0Fao3NtQTTC8YQzH9/Xj2ezmhkw6ngNK9DyvsAOCI
         yNCA==
X-Forwarded-Encrypted: i=1; AHgh+Rof58YsDg5RgtLDp33g7IuMYV5XRuCEvVdIqe/unWzASLpc38CwLLrw4UU5aEzW96tcgxQM/LA=@vger.kernel.org
X-Gm-Message-State: AFuF++nTWcV+7qevFfw/ULu+/abUfo0OuA/75EmwDAMRtu0kBey17Snz
	3vmDwtTxgjw4VyL0pZYzXEfw21R6EmCB+OhTNZzgJkQNDK/shce14lWZvmopV49ZXicladCd+CX
	3ashPpaKp5Ljb2A9vFymT3tW/IzXfDthkPIqAEsKo
X-Gm-Gg: AR+sD13EWPXi1J61KE1ZaUG5n3UMQgCtQTglgAwooUUcnFP829IWkfFY2/HLWXi4qOf
	UBVbzHTEoE8DfFglYNeMSkHW2yTDXWwH5iztrdZhv4mbhhGMC6I6sjKw3wDMccK+plvx2reW1Jr
	qvoVs2TxNxDWum2LzmdokCvjoWq/LtIQ5/ZPsUNueN7dX4+dUdY+XtpYrkCmGcWKICpgZWRrFBx
	/QJ2lxBcMCWR56rXSc9SuOXk8KV3zhj2El6t+CW6c4yUxuv8iKlmtCxCGYhmbtNZJQjanWzWvez
	XcWvnFUUJGhXuGym9DQsiFpO5L0ZK46/kCyyFpL6iNEd5x2fVmY+1Ro91FCDvn4GVY42HqnaNIo
	0/lqxIqyqNDyFt/YDRWSMpH1+ShDHv+JOoq6kUuh2RONyqTeuBpBXeMvt
X-Received: by 2002:ac8:5a4e:0:b0:51c:61a:50fa with SMTP id
 d75a77b69052e-52e09d26e41mr265645011cf.39.1787665388804; Tue, 25 Aug 2026
 06:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <34f44e8a-9fa4-4cb3-822e-5db54fb6df44@I-love.SAKURA.ne.jp>
 <CAAVpQUC672LJN_8KQ5BzadS26FnUrh4ayjyu-n5x=W7U69u7fA@mail.gmail.com>
 <CANn89iJd-s+mocDFXgt2rtFQVBGNJ7xEy=tUMKa5Da+brptXzA@mail.gmail.com>
 <7d6d4139-4389-4083-8569-ab2b7265ce3c@I-love.SAKURA.ne.jp>
 <CANn89iKwWFwRxEDvw7eUPD-tKL_dvYrZeye_3be37q6qYzQ15w@mail.gmail.com> <96f33d10-558f-49d5-a95d-ec1e29feea0b@I-love.SAKURA.ne.jp>
In-Reply-To: <96f33d10-558f-49d5-a95d-ec1e29feea0b@I-love.SAKURA.ne.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 15:42:56 +0200
X-Gm-Features: AcwNN1UAE-HhiRv43gFYMkUMIHvY3piRTIXDAKhqj-t9ywvd4sSPRs494hhUUjE
Message-ID: <CANn89iKLYk6vF6hJSgSTCndOJLZtr7EO7D8sue9YDLmVW+MxQw@mail.gmail.com>
Subject: Re: [PATCH] net: make sure final 'struct net' free in
 net_complete_free() is always deferred
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:21=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2026/08/17 23:00, Eric Dumazet wrote:
> > However, the observation regarding the copy_net_ns() error path is vali=
d:
> > because failed namespaces never go through __put_net(), net_cleanup_wor=
k
> > is not queued, so a failed net structure can stay on defer_free_list un=
til
> > another namespace is destroyed.
> >
> > The proper fix for that benign issue would be to directly free the
> > struct net in the
> > copy_net_ns() error path (since it was never active and does not need d=
eferred
> > freeing), rather than modifying cleanup_net().
>
> Now that "net: fix a resource leak in copy_net_ns() error handling path"
> handed over to net_passive_dec() (instead of calling kmem_cache_free() fr=
om
> copy_net_ns()), it is time to fix the last problem which sashiko repeated=
ly mentions
> due to commit 0f6ede9fbc74 ("net: defer final 'struct net' free in netns =
dismantle").
>
> My understanding is that we need to wait for RCU grace period before
> calling kmem_cache_free(). Then, I think we can simplify like shown below=
 (either
> pattern A or pattern B). Which pattern do you like?
>

Hi Tetsuo,

Neither Pattern A nor Pattern B is acceptable.

1. Pattern B fundamentally breaks the fix in commit 0f6ede9fbc74
   ("net: defer final 'struct net' free in netns dismantle") and reopens
   CVE-2024-56658:
   - A single RCU grace period (via call_rcu) is NOT sufficient.
   - dst_destroy() (and xfrm_dst referencing net->xfrm.xfrm[46]_dst_ops)
     can be invoked by RCU callbacks queued during dismantle or in
     cascading callbacks.
   - With call_rcu(), net_complete_free() would run in the same grace
     period as other dismantle callbacks, with no ordering guarantee across
     CPUs, resulting in kmem_cache_free() being called while callbacks
     are still accessing net fields.
   - If call_rcu() had been sufficient, we would not have introduced
     defer_free_list and cross-round deferral in the first place.

2. Pattern A introduces severe performance regressions:
   - rcu_barrier() is an expensive, synchronous system-wide operation.
   - cleanup_net() already runs rcu_barrier(). Spawning a worker on
     system_long_wq that runs an extra rcu_barrier() on every netns teardow=
n
     would cause unacceptable latency spikes and CPU stalls on systems
     with frequent container creation and destruction.

3. Regarding Sashiko's report:
   - This is a false positive from an automated tool lacking full
     architectural context.
   - cleanup_net() runs exclusively on the single-threaded netns_wq.
   - In cleanup_net(), net_complete_free() (llist_del_all) is executed
     strictly before net_passive_dec() (llist_add). A namespace being
     dismantled in round N is guaranteed to be placed on defer_free_list
     AFTER llist_del_all has completed, and will only be freed in round N+1
     or later after another full dismantle pass and rcu_barrier().
   - For external passive ref holders (e.g. kernel sockets), cleanup_net()
     and its rcu_barrier() already finished long ago, so freeing the
     structure once the last socket drops its reference is safe.

4. If you want to address failed namespaces in copy_net_ns(), the right fix
   is to directly free the struct net in the copy_net_ns() error path
   (since it was never published and never had active traffic/dst entries),
   not by changing net_passive_dec() or the dismantle path.

Thanks.
