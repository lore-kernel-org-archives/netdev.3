Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DB477E2A
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817571; cv=none; b=LYc9eosgyEzS30aBo52BE/A1fbnc30p8Q+QCpvPFlG15VmeuOutl0yT72GoOGo6KTalNiEgEiEgNeZ2wWF+95rTQO/mBQ7CQlCG/+Clvw+l8tscgYUUsUyZrOIWMGCbuCWGwxlFjkYmrpeNc55njf6XpivOzFvPgwTPxfvvEWPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817571; c=relaxed/simple;
	bh=epZHNJdb1jvaOZ4O6cy2hUvP2FOzogSGFkn2SNuLRcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbuho/ZH+skOdLUUhtlFZpNs9Qx0/Uq3yZsx4ZDgzKKOtkJqNS07nURzSU2uOBtzXgqNR/lS2IDqEYAmVgX7ioazNPFMhaCXHIOrSsOIKhWzW2mndJctNw8r7aFFlBWSdwuP8c3t8doGlMSxYRErvz//2EaIfM527Bw46TzP0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MP8n1E3w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqZTbsHk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP8n1E3w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqZTbsHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784817560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqFSWQaMTz+T5mXHuwtGx1/VHZD0uStv1s9M8jprGVg=;
	b=MP8n1E3wkpjQpj98nIEC11pHyU6OaUVvEILOWuYB/HQtvbZ/UgsLwaasA8ovyi8Hy9zFEt
	B4dOYSnt1Hh0SZuHKNFGIum4DlfQX8Kv1nN0CQJSix+cGa05+Cyi0QnxLUUXyMQ/PWfDVR
	Ci1QsCkvfoj6egblcfKV8TocKqtehFg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-8QZlOW9kMiSu-Q-VjyTtpA-1; Thu, 23 Jul 2026 10:39:19 -0400
X-MC-Unique: 8QZlOW9kMiSu-Q-VjyTtpA-1
X-Mimecast-MFC-AGG-ID: 8QZlOW9kMiSu-Q-VjyTtpA_1784817558
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f8580ed9eso738278f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784817558; x=1785422358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gqFSWQaMTz+T5mXHuwtGx1/VHZD0uStv1s9M8jprGVg=;
        b=DqZTbsHkwPFlgi2eQ9+fGTF0Hhz4PLPwe8mAwbFk0hCogSVheYZqe17I0Z0ZmtCi8n
         BGFmb4LG+0HvnFGF/FyXWqAZbhlebRocBpDtbRJR5SwXNARdw9vCJGD7lM3iHaCfHeUB
         T+uU3IuNbvfbR0mSLlD3ML8knFcFfLxFnrpPblnG639VoJRKdQoRAQAU4wCTjKEj1hOv
         5LjcgSh8+2+NVwVmFTqr4FyR4fdgvtZYYmZwJpF2amPiHYxkQf955UcqoLpRWHH0qnHy
         OqOBLyk4OqddpdiWRAtn4OU5ygh1pqUXfa/MbfYqv9mGBm3Csx93ac7QpJEhBDuoK6EU
         EkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817558; x=1785422358;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gqFSWQaMTz+T5mXHuwtGx1/VHZD0uStv1s9M8jprGVg=;
        b=KAunb83JsGIGt0G+MYX8BFsArhHlm6G4uBtdvPoQZvmXWGfWve41sPTjDHszz13mh5
         w4FjNKVCeQsXc/eP1KvOAbZhXMQ9epipbZadot1EAnEKjz9hEDoLiHiAKPygYZk6q8hm
         qGvUP2iuUAGEQC8NxXhUHa48gMx4lboBfDBGYggNKK9po6/2bX0qifTMC8t96iutbOXs
         buKjd3g5/1z7oSPlj7Xb5IXZwcddiQgQEeBp3DzmKJ+s3v9bSV+PuuXFKOQ1yWsv9Gn7
         OAWAR4gTfCQzo4DZBoKQrjEKx3UNDXzH3J4wjOvzsLfeYo0hP03t8i4hUGRoZlvu8FbH
         T7mA==
X-Forwarded-Encrypted: i=1; AHgh+RpCB0WvpcAuZKIcZg5YPif8zvhe9Wmq9mAAc5r3K4WYDNG4ZZkhSwkx8J4pySvacYDAlZSXdOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYDXkZUAw/4NINs4uFK1uNiMeOxTjR4phnolpJxtXj+BzU+l8
	724C/tZSkMnFeOCKrzWhauUwVBNZ8E45G+X0Zpj6+SDcPe3jzDYkdD2KkNb/vkSzRQ3yXvghA2Z
	RsWCbluOAtcYUHNH1hrEiywX3Ra5UEVXYA7FLu1TW0xN9vwsX7ZubPWks7g==
X-Gm-Gg: AR+sD102L4/W6IJMAmD/ejWs1aEclcpIFTfD/iOMpQMmo1z3VrqR1idTSisg/cuj0TD
	6aBkk6L5VNursWcwWFOasqOpfEHSqR9xwLImvGGOW2NnvVY3wALXm38lecqSDRCu+i19gGBBV7x
	0yk5RR+iTjquHI8+x0Xu+ap1pAynljFprpTrrvQzyB+qh+d8iP/gy7AA9NoXFkZYMXQ3/IIUXTU
	inbr14PLo0QwIw5MPz5OhNaM+u0gsuzP2rwHho3mCTfjmYDW5D+InzZhihd7q4WcAEn/0CAMd0x
	Xz1bE3LoMtnfgFq65rmV/OdmEhQN57VQXhQoT3bePRaDlUljXMLKPHD5rcpbUjapYROcQxYNBHN
	szKGqfIqV6mo272fsqmNuqHLwoiYFDVPhZl+Rbz6PoTyEAu337Q==
X-Received: by 2002:a5d:5e87:0:b0:47f:6d9a:d7a6 with SMTP id ffacd0b85a97d-47f8d72996fmr4387771f8f.25.1784817557333;
        Thu, 23 Jul 2026 07:39:17 -0700 (PDT)
X-Received: by 2002:a5d:5e87:0:b0:47f:6d9a:d7a6 with SMTP id ffacd0b85a97d-47f8d72996fmr4387716f8f.25.1784817556761;
        Thu, 23 Jul 2026 07:39:16 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531basm15770037f8f.19.2026.07.23.07.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:39:15 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:39:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <amInL2hPEG9ejUd0@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <amCPLOrnpYmr5n0p@sgarzare-redhat>
 <82066fcb-150f-47ef-86a7-0df0f9eb41c5@virtuozzo.com>
 <amIe79X3j7GxDBdO@sgarzare-redhat>
 <f21667c3-64f1-40c6-9941-9453af173eda@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f21667c3-64f1-40c6-9941-9453af173eda@virtuozzo.com>

On Thu, Jul 23, 2026 at 05:29:12PM +0300, Andrey Drobyshev wrote:
>On 7/23/26 5:03 PM, Stefano Garzarella wrote:
>> On Thu, Jul 23, 2026 at 04:57:47PM +0300, Andrey Drobyshev wrote:
>>> On 7/22/26 12:43 PM, Stefano Garzarella wrote:
>>>> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>>>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>>>>> vq->worker and queues work on it.  vhost_workers_free() however clears
>>>>> the vq->worker pointers and immediately frees the workers, without
>>>>> waiting for a grace period.  A caller that fetched the worker right
>>>>> before the pointer was cleared can therefore still be queueing work on
>>>>> it while it is freed.  And even when the queueing itself wins the race,
>>>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>>>>> future attempts to queue it are silently skipped.
>>>>>
>>>>> None of the current callers can actually hit this: net and scsi stop
>>>>> their virtqueues before the workers are freed, and vsock unhashes the
>>>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>>>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>>>>> in vhost-vsock keeps the device hashed while its workers are freed, so
>>>>> the lockless send/cancel paths become able to race with the teardown.
>>>>>
>>>>> Fix this by clearing the vq->worker pointers, waiting for a grace
>>>>> period, and then flushing the workers so any work the last readers
>>>>> queued runs before the workers are freed.
>>>>>
>>>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>> ---
>>>>> drivers/vhost/vhost.c | 11 +++++++++++
>>>>> 1 file changed, 11 insertions(+)
>>>>
>>>> Sashiko reported some potential issues here:
>>>> https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4
>>>>
>>>> IMO the first one is pre-existing, but not really sure it is a real
>>>> issue since happening when the worker/vmm is going to be killed.
>>>>
>>>
>>> Sashiko claims:
>>>
>>>> Will this leave the queued work unexecuted and permanently break the
>>> virtqueue by leaving VHOST_WORK_QUEUED set?
>>>
>>> I agree this issue is pre-existing and doesn't have much to do with our
>>> series here.  It looks real, but in reality should be harmless since we
>>> may only hit it while the device already dying.  Means there's no VQ
>>> state to be saved.  The only potentially observable artifact I guess is
>>> a warning here:
>>>
>>> vhost_workers_free()
>>>  vhost_worker_destroy()
>>>    WARN_ON(!llist_empty())
>>>
>>> So more of a cosmetic noise on a dying device.  Again, not relevant to
>>> this series.  But one optional way to make it go away would be to clear
>>> vq->worker under vq->mutex in vhost_workers_free() (mirroring
>>> vhost_worker_killed()).
>>>> The second one also not sure if it's an issue since the sender is not
>>>> lockless IIUC.
>>>>
>>>
>>> The term 'sender' is confusing here:
>>>
>>> * vhost_transport_send_pkt() is the .send_pkt() method of struct
>>> virtio_transport.  It only stores skbs into the queue, doesn't process
>>> them. It indeed is lockless as it doesn't take vq->mutex.
>>>
>>> * vhost_transport_send_pkt_work() is the .fn() method of send_pkt_work.
>>> It's called by the worker thread to process skbs in the queue, calls
>>> vhost_transport_do_send_pkt() which does in turn take vq->mutex.
>>>
>>> I think sashiko points out to the former.  Still, I don't think it's an
>>> actual bug.  Look:
>>>
>>> 1) By invoking flush, we wake the worker thread:
>>> vhost_dev_flush()
>>>  __vhost_worker_flush()
>>>    vhost_worker_queue(flush.work)
>>>      worker->ops->wakeup()
>>>
>>> 2) Then woken worker does:
>>> vhost_run_work_list()
>>>  llist_for_each_entry_safe(work) {
>>>    clear_bit(VHOST_WORK_QUEUED, &work->flags)
>>>    work->fn(work) // for send_pkt_work = vhost_transport_send_pkt_work
>>>  }
>>>
>>> 3) And then in work->fn() (vhost_transport_send_pkt_work):
>>> vhost_transport_send_pkt_work()
>>>  vhost_transport_do_send_pkt()
>>>    if (!vhost_vq_get_backend(vq))
>>>      goto out;
>>>
>>> As you can see, we return early in case backend was unset.
>>>
>>> So after doing this flush, we have: 1) QUEUED bit is unset; that makes
>>> send_pkt_work re-queueable. 2) But the queue doesn't actually get
>>> processed, and VQ state isn't actually touched here - so I guess
>>> Sashiko's conclusion is incorrect and there's no actual bug.
>>>
>>>> But, please can you double check them?
>>>>
>>>
>>> In general I'd leave this patch as-is as Sashiko's complaints aren't
>>> very convincing so far.  If you want I can add another patch which wraps
>>> NULLifying workers in vhost_workers_free() in vq->mutex.
>>>
>>> WDYT?
>>
>> Yeah, I agree, about the other patch, up to you, but I'll eventually
>> send it separately.
>>
>> Thanks,
>> Stefano
>>
>
>Alright, then let me resend it once more along with this 6th patch, so
>that we don't have it uncovered.

But why it should be part of this series?

If there is no strong reason, I'd send it as a separate patch.

E.g. even this patch in theory may be a separate one, but this is 
related to this series, so makes sense to have this included.

Thanks,
Stefano

