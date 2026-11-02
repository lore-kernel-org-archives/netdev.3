Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656869;
	b=A6XDW4pvmZqIwMW2TxrDT2L+pXican1FmOHmUTA4swyVub+ShNlaDMyin1rlXT8xaEqX
	 ZUZGSEbeRMTPGn5O8WwxCniCV7o494CNGmQL+p9T6l6nTP8mmLQ1hl3zkOR2E8FTzLls8
	 gAJBWunJ44GteXeacEU5kNPOBsgsKpMWiX14XMs53NEDGvJAsDet5vcoojS4Ofv5Zz546
	 y/ciKbpeCQbbdRkke0H4aCMeTIgr/q6u+60T6g3jpNtHRcX4fRSQiuE0AJbMcUbXmMkyt
	 vy6tMhKnVQpFpud0fJbAN9TiW9aG8rYc/7LWB0DmokAYP0lMBDHaHnAkO9tILzgpmvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656869;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nmYBbIk5usy6FeDyc+DCeJpHSSfN/V5GCfHKFupvluE=;
	b=5c3X5g1P3hNhk6LzL6dKElKF+5d5oYmoXLzSqM7zhCSFq1n3J8KwqfkbkUHdHYLpNgrV
	 LSY6tIqDA6oJeXWWoxylKKmKfU4rR2u13YzCZYk6ndOMNCCb8IzPUy80RZujnCb/fws1K
	 vB7U6E9C1XhbbjJ+Il3AH5LEZnhXwaY6yDt3VjVEfrCyI88ENyY19HrMG/gEo49XIijej
	 l9yglILaAM2AsvxXPueXPGAOAvtecLnc3DpH9/VBX90k8xei4mCk06QLvIN5JICW8ownU
	 R7VATfw6KbBwrWRg0UuvkS3Gt3Y69tVATpnhY60Db1iAGnJI88rHQiMvYddElfMDoew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="JY/wmp8u";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kxub1Oep;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AD606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 22:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 937AD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JY/wmp8u;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kxub1Oep
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793656867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmYBbIk5usy6FeDyc+DCeJpHSSfN/V5GCfHKFupvluE=;
	b=JY/wmp8uEajzUkf1vNeZ7IdqqrYGiqbB+JyZfHIwoBnRWFnXx6MxOMBQ1QPWUuN47HN3vw
	WfXsqF3y2s4CK8roeZtKzy6VSl6JCH36pHlSmbwr5v1VaCKfqJsb28FskLBuSe+4H8NHu8
	7PydJ4vC0jswAldSb+/rh1oN5K8jTB0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-jm1JGgQ9NeWYlr7yfB84Mg-1; Mon, 02 Nov 2026 17:01:06 -0500
X-MC-Unique: jm1JGgQ9NeWYlr7yfB84Mg-1
X-Mimecast-MFC-AGG-ID: jm1JGgQ9NeWYlr7yfB84Mg_1793656865
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b01a74792so2328933f8f.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 14:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793656865; x=1794261665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmYBbIk5usy6FeDyc+DCeJpHSSfN/V5GCfHKFupvluE=;
        b=kxub1OepQwqzw4DlS3rfA1OfAXqLMScfhFOmzNrJ1pTHliNk1VVITv2fVQ/UPxKoLU
         QfvGseif6c5bt0WFIJ0q12sb2pzR4u2J4YfJgBY7U8Om8in4RhWC7yMK34FmrE+4GSz+
         5gXSOvnknqCcZQQIYxRFUSH+fmdwg/m1R0R8VfsuasglNTZRYb1vc9L4ZSq03EUkFDpQ
         EDxoO11i0GUZyyb3Z5IUsmyft32Qt8D4a3HtGkVBQt9F6v0zVqPJqQvaXlauDKBuBqnI
         GfhxNDuwUIHctovuzeuFDmtxLnWhbV/XbrnwbJ+DDZqa2/otPHbkMbnwSEawQFS4m4PK
         1XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656865; x=1794261665;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nmYBbIk5usy6FeDyc+DCeJpHSSfN/V5GCfHKFupvluE=;
        b=Ft6Z+rXrdv/TRaSqEEW1xP/ckmlBAZ/hsZbsKeoIk/Vpd+tOwzJUpWz2em2Eo11IyO
         RQeN8jH4fqR1dbvqw7vVIm7JrfO/yKAEDpTnfzFCwRza6EEVe7FYFnfAud6k1TAcdWII
         1cFrZr94PUUnDqGF/hvjlhONyABjnAwcK+h5rf2InWw8/jm8roEccT8Uub4fyRkrVgBk
         y98fCNyy5nm59gudcJ7pw7OuuCJ9MpRm/tb4G3z3PJLsVug+TQY8so48V3qzx7vE93Ej
         Q+c+DnrmSo4WxOftfOJ+lcku0bXQjckncQIC9xkQUTPSp1C0u7qyK59zoCcKlg4CwBdp
         PtBA==
X-Forwarded-Encrypted: i=1; AKwUvBxeHCI/kJK34p9VM+44BnFOHc66nAFsF7TXrG7A+uFU4BmQGycR/KLkNiOlUrMVlZSSQtaloKs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Rk2eeLW5eexSOwS6N+aadNu14gUgPDBBLgozI8r5mSJ4KI0yC
	rc15c7cnrOt4vrfVHNYx/fHRGS16fBSfXRvQUkgiK3DzYnCiIXT+pxCTFpTvtiD646bsmdvbQu4
	vod8ouUzl0VgshmytsCs0QR75GbLS9O8/nFN1S+Isxg3xsNBfq7Mq+WRRhw==
X-Gm-Gg: AYBFou1vi+3SThwP+XB20i90n0gCdLJ1r9Q1NEZAPr9qDSDsWHRWPDdAzdArxE7B2UQ
	7MgdAkiP4OODjuWqwwYr5+XGP/ZCSi8QhWWpzzp5qgs8i8LGHRbSnQgstYJjZGA96Qb6m0mLRvG
	tTeX2yCu+x+6CePSU1eyOtzH4kJ/nCcU3z9sxK7xP1gCtWCbOZO6QMBRb7NJ1B6VKioQ1A4VYQc
	lGC0DBkKcofAIaznsc/3b6OK4h0h+XKwW5HQZa44bpEDdwivP0EdgUapaIIeDSVTkmTRAXkdEg0
	EmD6QQCcI2W/ECARl8osYzUG5co5ijeLBBMMw3SQ+XqjajnQVE6kBambYVlfDzUPAeFaj8ktnxC
	vYYKOhHirsYVtHzN5ktVNLQwb96xgkcdCKCXO2SFFpph4UEFbYi8kiOD1S/u32Cdcn94HiqyQ8e
	4nkIKafFiyLwBPpDN9/4dtx4JiFS+fxBWYPiLwGKM828s=
X-Received: by 2002:a5d:5f41:0:b0:48e:68d5:818d with SMTP id ffacd0b85a97d-48e6e2eb83emr27445801f8f.16.1793656864987;
        Mon, 02 Nov 2026 14:01:04 -0800 (PST)
X-Received: by 2002:a5d:5f41:0:b0:48e:68d5:818d with SMTP id ffacd0b85a97d-48e6e2eb83emr27445750f8f.16.1793656864628;
        Mon, 02 Nov 2026 14:01:04 -0800 (PST)
Received: from [192.168.88.29] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71baa1b3sm20953601f8f.56.2026.11.02.14.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:01:03 -0800 (PST)
Message-ID: <f4f0fbd6-63e4-42d3-87bf-9f888a8de1a8@redhat.com>
Date: Mon, 2 Nov 2026 23:01:00 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on
 queue uninstall
To: Mina Almasry <almasrymina@google.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 sdf@fomichev.me, kaiyuanz@google.com, kuba@kernel.org,
 bobbyeshleman@meta.com, asml.silence@gmail.com, dw@davidwei.uk,
 ap420073@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 horms@kernel.org, shuah@kernel.org, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org, andrew+netdev@lunn.ch,
 sdf.kernel@gmail.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 daniel@iogearbox.net, razor@blackwall.org, tariqt@nvidia.com,
 kaifengw@google.com, dtatulea@nvidia.com
References: <20261030083539.777877-2-almasrymina@google.com>
 <179357408146.3131.2882435952119280563@kernel.org>
 <CAHS8izMt+5HBjkOOsb-FrwKoXxEBuDn=gf5p+64akYS=SAoQrQ@mail.gmail.com>
 <9afff44d-f8eb-4549-8aae-f99a53339319@redhat.com>
 <20261102185856.1824792-1-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102185856.1824792-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 19:58, Mina Almasry wrote:
> On Mon, Nov 2, 2026 at 7:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 11/2/26 00:16, Mina Almasry wrote:
>>> On Sun, Nov 1, 2026 at 3:01 PM <netdev-bot+sashiko@kernel.org> wrote:
>>>>
>>>> - [High] The dma_dev use-after-free this patch says it fixes can still
>>>>     happen for RX bindings made on a virtual device that leases queues,...
>>>>
>>>
>>> I know about the issues with leased devices. That needs a bit of a
>>> rework, which I have done locally, and would like to send out as a
>>> follow up fix.
>> Will such follow-up rework the code touched by  current patch/series?
>> how much? I'm under the impression that at least the fix for the issue
>> reported here would be quite overlapping.
>>
>> /P
> 
> I pushed the follow-up branch on top of v5 here so you can see the exact diff:
> https://github.com/mina/linux/compare/devmem-teardown-v4...devmem-lease-bind-map-dev
> (commits: https://github.com/mina/linux/commits/devmem-lease-bind-map-dev)
> 
> There is some overlap (~55 lines of v5 touched across a 6-patch +262/-99
> follow-up): it renames binding->dev/vdev to binding->map_dev/bind_dev, passes
> the net_device explicitly to net_devmem_lock_dev(), factors out
> net_devmem_close_rxqs(), and replaces the !rxq->lease / !netif_is_queue_leasee()
> skips in net_devmem_dev_unregister() and mp_dmabuf_devmem_uninstall().
> 
> I kept it separate only to keep this net fix smaller and easier to review,
> since the lease issue is pre-existing. Happy to either land v5 first and send
> those 6 patches right after, or fold them into a v6 if you prefer avoiding the
> churn.
I hoped for something smaller :)

I definitely would not fold the 2 series.

I'm wondering if this could be considered net-next material? pointing to
net-next will offer better guarantees for all the work to land in the same
release (no need to repost in such a case, I can apply this one to net-next
directly).

/P

