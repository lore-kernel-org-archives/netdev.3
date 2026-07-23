Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F003339847
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815414; cv=none; b=hBn5HAByG78f58mT6corFhHPh5tFjneXSIbvq99sg03om9SqkNlm/YNdEMmFL/908a7ou1gfSnPJVK5jimNkVDW91B6vwhch1Pv2pL9sWMj7wlmOW3C2lXIdGfXn5JUf6cZnQWa9QKgKM5aaLEiZPf4ujt44QBeYS5jnFHnKl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815414; c=relaxed/simple;
	bh=EVWutf23s/oOQfhofJPqDNYbR+2MaeOSPLVgIc90TwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG8jKlkEZnTRhPAO5bmOX+bVlpZRDTafBCXgubBvrzw0HucCRwp8WLn90bE8DvotN1jLvoyJLoWEGApFvHZiP5XSHLyEC+c3p5N85154qB8jc1srsOzs6YmTgTY6kbFZm33TpBPFJ2xwjGkG4osx38DOTNA2GFgv6I67pr4HVkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnD9hTrG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIk+ceNl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnD9hTrG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIk+ceNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784815411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KHv44vLStOGdeWCOIZDC6gv5b89UGcYrbfGwIxzvwo=;
	b=cnD9hTrGJX6x4xuI0VHTEikp3F+plGjKZ/7cuu1NHqK7NJnFFCTa9XXahObY2TL8BsBmSR
	Tcm1ZtB+55yzKqLV9qPvQsGxWjC3fmKFJmkXK4ghoheoKiH58N1/WyVBl/bnJ7gz75rzyj
	RZqQp/4YC1nocqUO8lyFM6gUgYYho58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-JeIvQctNNLOx5T6JWnSwjg-1; Thu, 23 Jul 2026 10:03:30 -0400
X-MC-Unique: JeIvQctNNLOx5T6JWnSwjg-1
X-Mimecast-MFC-AGG-ID: JeIvQctNNLOx5T6JWnSwjg_1784815409
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso5130375e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784815409; x=1785420209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0KHv44vLStOGdeWCOIZDC6gv5b89UGcYrbfGwIxzvwo=;
        b=LIk+ceNlWnMDMUQycCheZZ+CBsfGI9HSlxO1cOJG2UVkVwQSJOM3tLfWdpbIi1LP91
         kJ9OtiWCq3RumUKZDXezjagNB0SG43RA5WSzSlKMNQ+JQMwQrVp67gMtqmnhwqD5R6vM
         DyP6fL0rzTDCCCW3gJD5sjgGwPwzhLnIS1PIzolj+KvqVOapb4N8Q/oQV0DKCiUBdEZh
         iqxBTm084ZGCClwzCH6yXtQhBJ8nm77/+63Akq4hljYCfrZEE+84gQ0fifyJbLYgjEBT
         J3g7OB3jkCzcir+4rPEJCrgZbSuSvpU9jTf2s2KzizO7zLw6mMQst4+Pwbhf5vJ61pFA
         xHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815409; x=1785420209;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0KHv44vLStOGdeWCOIZDC6gv5b89UGcYrbfGwIxzvwo=;
        b=otswxV4/UUq3a4qH+Mt+0x3aRF41h3sN9p/oVz+wfJ7fdX2rnF2QKw6cV4vjSVHaeh
         siedYH0vsiy42/4I6luPrhG4GMLjms3fh5t0PXZu37vyfYpdKVsJbouyzqPBkKJsXejN
         4Xbz4QM1tuROaMCXaJl+TLiVMdwG3DIBy4yjWdAGgF/yB9Ysu2++657ZIVz+cQaSkyy9
         lbc4lK+WLTWd6CBT0tM64QGlNDjCG2AXITO9u/BYqX77kTQ10cyAynsv4gcMluN660J0
         Fr2pL/Q36rMh/1PiSyWNgxlsPBECu23fFtelMzBu599VuGY/0FqFm7O2OlgUnVcz3NGC
         3mfA==
X-Forwarded-Encrypted: i=1; AHgh+RrUhvDK0gzLcNxyRetqnGyyC8qnCKLtk3aXatlWsh6G8eUGOjew9XCHjkHVcayxg7sCXQxYk5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuaOn4Mgn7CW175HpqNpE68PU136iIIoiAlw0DnCjyaU8nUnw
	qApzMt4r11vUAnvZM1N95fWPpVB/6UcZmVr1TkdxmDN+QHLv85qyTvBBPmRg7VJo6lpOND++HzB
	cQNctuiseK5LimEQXJkPf7oT819yq1JhifIXaLPW143vHl+ZX3fW8Kj7Ghg==
X-Gm-Gg: AR+sD12c9F3wuUCNTZdplrfZLD3f2ejICoyqWHcTKVrsjaCZptjJX+HQnkdS3+qOSN0
	VcpxIZ8V/XA9SOAlKAz2A660KnKoFxxR7NFQxjRQwj9QWCWYiP7jhNdwxT39O6IS/B2gqFBRwJM
	YK/9Q5T16cSnBHNnOZs47PHgrwd8yH4SXiIUVeNXLmD5Jw6oCruliYUrgPe7kLKd+1nj2Zr4wFC
	6dtB7wusMgBd5RCv3o4h+eMdv4rR8dtLjCcRZZfRN+1XXeWJokAPmUN6S92hASU0NktWg1TS5p8
	zPyQ6UpPDDuOzgYS6k+UCXtS8+wl6uIXKrSckvoe/PIXaQx0N/OeGOBGJ+Va79mW/YIHxK7vnoN
	ZGCUfnsUHHpHP+cQYZ+b7jKXaiD6acleSHPgTApZEd4DiFuE5kQ==
X-Received: by 2002:a05:600c:8b83:b0:495:515a:dad9 with SMTP id 5b1f17b1804b1-49573cf8131mr35830915e9.37.1784815408690;
        Thu, 23 Jul 2026 07:03:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8b83:b0:495:515a:dad9 with SMTP id 5b1f17b1804b1-49573cf8131mr35829775e9.37.1784815407871;
        Thu, 23 Jul 2026 07:03:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956536870esm228444165e9.3.2026.07.23.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:03:26 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:03:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <amIe79X3j7GxDBdO@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <amCPLOrnpYmr5n0p@sgarzare-redhat>
 <82066fcb-150f-47ef-86a7-0df0f9eb41c5@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <82066fcb-150f-47ef-86a7-0df0f9eb41c5@virtuozzo.com>

On Thu, Jul 23, 2026 at 04:57:47PM +0300, Andrey Drobyshev wrote:
>On 7/22/26 12:43 PM, Stefano Garzarella wrote:
>> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>>> vq->worker and queues work on it.  vhost_workers_free() however clears
>>> the vq->worker pointers and immediately frees the workers, without
>>> waiting for a grace period.  A caller that fetched the worker right
>>> before the pointer was cleared can therefore still be queueing work on
>>> it while it is freed.  And even when the queueing itself wins the race,
>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>>> future attempts to queue it are silently skipped.
>>>
>>> None of the current callers can actually hit this: net and scsi stop
>>> their virtqueues before the workers are freed, and vsock unhashes the
>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>>> in vhost-vsock keeps the device hashed while its workers are freed, so
>>> the lockless send/cancel paths become able to race with the teardown.
>>>
>>> Fix this by clearing the vq->worker pointers, waiting for a grace
>>> period, and then flushing the workers so any work the last readers
>>> queued runs before the workers are freed.
>>>
>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>> drivers/vhost/vhost.c | 11 +++++++++++
>>> 1 file changed, 11 insertions(+)
>>
>> Sashiko reported some potential issues here:
>> https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4
>>
>> IMO the first one is pre-existing, but not really sure it is a real
>> issue since happening when the worker/vmm is going to be killed.
>>
>
>Sashiko claims:
>
>> Will this leave the queued work unexecuted and permanently break the
>virtqueue by leaving VHOST_WORK_QUEUED set?
>
>I agree this issue is pre-existing and doesn't have much to do with our
>series here.  It looks real, but in reality should be harmless since we
>may only hit it while the device already dying.  Means there's no VQ
>state to be saved.  The only potentially observable artifact I guess is
>a warning here:
>
>vhost_workers_free()
>  vhost_worker_destroy()
>    WARN_ON(!llist_empty())
>
>So more of a cosmetic noise on a dying device.  Again, not relevant to
>this series.  But one optional way to make it go away would be to clear
>vq->worker under vq->mutex in vhost_workers_free() (mirroring
>vhost_worker_killed()).
>> The second one also not sure if it's an issue since the sender is not
>> lockless IIUC.
>>
>
>The term 'sender' is confusing here:
>
>* vhost_transport_send_pkt() is the .send_pkt() method of struct
>virtio_transport.  It only stores skbs into the queue, doesn't process
>them. It indeed is lockless as it doesn't take vq->mutex.
>
>* vhost_transport_send_pkt_work() is the .fn() method of send_pkt_work.
>It's called by the worker thread to process skbs in the queue, calls
>vhost_transport_do_send_pkt() which does in turn take vq->mutex.
>
>I think sashiko points out to the former.  Still, I don't think it's an
>actual bug.  Look:
>
>1) By invoking flush, we wake the worker thread:
>vhost_dev_flush()
>  __vhost_worker_flush()
>    vhost_worker_queue(flush.work)
>      worker->ops->wakeup()
>
>2) Then woken worker does:
>vhost_run_work_list()
>  llist_for_each_entry_safe(work) {
>    clear_bit(VHOST_WORK_QUEUED, &work->flags)
>    work->fn(work) // for send_pkt_work = vhost_transport_send_pkt_work
>  }
>
>3) And then in work->fn() (vhost_transport_send_pkt_work):
>vhost_transport_send_pkt_work()
>  vhost_transport_do_send_pkt()
>    if (!vhost_vq_get_backend(vq))
>      goto out;
>
>As you can see, we return early in case backend was unset.
>
>So after doing this flush, we have: 1) QUEUED bit is unset; that makes
>send_pkt_work re-queueable. 2) But the queue doesn't actually get
>processed, and VQ state isn't actually touched here - so I guess
>Sashiko's conclusion is incorrect and there's no actual bug.
>
>> But, please can you double check them?
>>
>
>In general I'd leave this patch as-is as Sashiko's complaints aren't
>very convincing so far.  If you want I can add another patch which wraps
>NULLifying workers in vhost_workers_free() in vq->mutex.
>
>WDYT?

Yeah, I agree, about the other patch, up to you, but I'll eventually 
send it separately.

Thanks,
Stefano

