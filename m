Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28D3B2D18
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218394; cv=none; b=cyOu4I/RhcK5qDFOlzAdtNrYKPLXZK0XlMRxiG/FHa4IPIyBEJOt18T+tgITptUD2XRgYJg+Y0TW5lCrZtMiPBU3MfDx7/bNgvSZ+QTtbFWKRg3sKTqLaa5LfYcpd46oIj1vbrWYoPr3Mj+aqnpwvEdPWEcc1ytwI8/MF1Z8S20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218394; c=relaxed/simple;
	bh=kKKZU3L+6reK4B7gcJARVHlxz60vhrpuTNd2xoB+G8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryYouxir2ElFTHOPc6NI3CXlc4oXcyx+i5AI2Fsmnr2i/96DR9sPRD93uOqe9Sv7TjMZlyDlggIqS8oK/6No2uN/Ggs4V1Dq4LCaPJzdVLHAvDMaD1dT0fztrZDiEC6baPLCpSf1kFehUssxVpM/NEDEb/8KJpISgeu6FiBFRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T36//J4J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dt4uYwX7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T36//J4J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dt4uYwX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784218391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9r6s/Iraoqi/k6oOHzDzgVXH/SASqKiz7NyQ8JhZ6M=;
	b=T36//J4JH3qMz3pMg+qskoDH1IQhaQQeispSwaCDBTY7LhA7mGtaJrh9qqHRJBWzOxGlhf
	iYKOSCGXV+c7onYlcFItvFjNEV2D14bzAVdBhzddrG3WeKg3NxVvicD/JzDwaCki+J++Gl
	Sc9Zd4UHlYJPnl6EuS4UjL9WvMpYdnE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-xNgKE19PO2y4Y4oJxKCfuw-1; Thu, 16 Jul 2026 12:13:10 -0400
X-MC-Unique: xNgKE19PO2y4Y4oJxKCfuw-1
X-Mimecast-MFC-AGG-ID: xNgKE19PO2y4Y4oJxKCfuw_1784218389
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-474170b59dfso3916998f8f.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784218389; x=1784823189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x9r6s/Iraoqi/k6oOHzDzgVXH/SASqKiz7NyQ8JhZ6M=;
        b=dt4uYwX7EYt46fsT6WqnWoMbi6wUVXURuB0b7YbA8MINGXJ4GP0h6IiazDw6NrVo7A
         /b8sepZ3CYyCY7uFRqz5m68Pkd+tbJRA36Y8jOpLUbrwEItNO9ELq2NDeDdOUg2hq11X
         Sep4/FS473fP7WqO/Q9fPhF9BBKKn9SdJ+uZD0IuZqoK2Sdn1BKr/RfSajd4NxNbpkU/
         ormc3uWp9A0FjHABDTZ2ioLt2lw0TpmqI02ZMWo2cavtvFyT5FbblvXxgbvyhRfuXO6t
         1sv0cW4cq6OUT5o8+K87mfqV7M1W9PMA/XU52OQporTFSCf7ooix8apM7GvcGyWI5v20
         2Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218389; x=1784823189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9r6s/Iraoqi/k6oOHzDzgVXH/SASqKiz7NyQ8JhZ6M=;
        b=GNID8q0C17JaxSzXQU+rsn3MaDqOiW/loI93nahdk6MEMH2P7/4JPx0JgYfWWGpa1K
         FgU9rXrTs/6cri8jtj85YOriIOosI74AECNuwhMRoHW7wuoYK8HDjLqi3F8q3gntSKE+
         0kb0D6J4HU6QECrgoenEqDTYA0FBl+EVWja9QupaKjCgSUIGCZ0Nx9SUHPADwGmnT53l
         t88jK3WOM7iFa99ERyjf0byYGjRhLcyL9FUbSsEsOa5NBcL5+lbvNH5/RSJQZI87GELz
         hUhAjkoI28+UXRaL18p4N3mJqgBz/rmO5XutysJmsxxFpau8DZKKQjyOxcptqdqYpCjj
         QkuA==
X-Forwarded-Encrypted: i=1; AHgh+RqGEBcL9KClJWHbbKhuAbtgtse1IpFaN9+JM4hhsyV5ukSmNqcKTh3rR+1B3Zm7n2pEOjhE8p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/8FlaFql6U35TsA0DWKlN7385O9/iJOZTvsFUJm7+5dNUY61
	B0y1rNSYIW9JYCZOJR8WmoTzqfo1XEaztjHcqB1o9I2FSLoAqZpTPCCCVSCCqzFzw8o7/QMFayz
	wtG7XaXNb/sDrwYit/vtaRP55sGNbNjO87YQahVTY7dM+tfd1QXYBeJ3MeA==
X-Gm-Gg: AfdE7ckn7px2v/I3IQOWzNObbRxEzicfu0IaxS3J8E+m90airsj/yQIVYbKPUtKJBqR
	3RY0TEjwOUxgmwL7ipas68/hAiJusuoT7s+fosPYw9VO5RIW70ZJdUQ/LaXeiSba1lMrzVc/Kxh
	L5vQUaa/6XzUFUgsTs7AALdenWjLaC/S45q5EvaVoubRyCRqgA6pmDn0/g1TzYuzTd/j/HoGvox
	gtOFbhV6zapJLWb9VGmtxC8KSM0n0uXI31Dgq6jDzss9hoMfOwbU6HMPJIUNY+i796Wnxd5ZeE6
	6hhckLvfKNt65RGbGiJTsNgTeoDsFxqZ/KqrfTlxQzl2kZf4J1S/tTZupSAJduj0W1RHEuYOlNU
	JiHOKScrAaDLkW12OYAvrLk89e+v3Axd4f1Vfq+vZcqHEpLryyg==
X-Received: by 2002:a05:600d:6445:20b0:495:4182:444c with SMTP id 5b1f17b1804b1-49541824759mr38415345e9.26.1784218389348;
        Thu, 16 Jul 2026 09:13:09 -0700 (PDT)
X-Received: by 2002:a05:600d:6445:20b0:495:4182:444c with SMTP id 5b1f17b1804b1-49541824759mr38414535e9.26.1784218388605;
        Thu, 16 Jul 2026 09:13:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9ee07sm70836725e9.15.2026.07.16.09.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:13:07 -0700 (PDT)
Date: Thu, 16 Jul 2026 18:13:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v4 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <alj_YKTitwqMjAez@sgarzare-redhat>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
 <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
 <alibLtcrC7o5r4Dh@sgarzare-redhat>
 <2f680236-f4c1-418b-8401-4dea1230caf0@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2f680236-f4c1-418b-8401-4dea1230caf0@virtuozzo.com>

On Thu, Jul 16, 2026 at 06:39:48PM +0300, Andrey Drobyshev wrote:
>On 7/16/26 11:57 AM, Stefano Garzarella wrote:
>> On Tue, Jul 14, 2026 at 06:16:37PM +0300, Andrey Drobyshev wrote:
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
>>> Close this the way vhost_worker_killed() already does: clear the
>>> vq->worker pointers, wait for a grace period, run whatever the last
>>> readers may have queued, and only then free the workers.  The
>>> synchronize_rcu() is skipped if the device has no workers, so cleanup of
>>> devices which never got an owner stays cheap.
>>>
>>
>> Do we need a Fixes tag for this?
>>
>
>I'm guessing it should be:
>
>Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>
>> Thanks for pointing out that the issue wasn't occurring, but I think we
>> should add it because it's a sneaky problem we discovered by chance.
>> IMO the code should already have `synchronize_rcu()` after
>> `rcu_assign_pointer()` loop.
>>
>> @Michael, what do you think?
>>
>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>> drivers/vhost/vhost.c | 15 +++++++++++++++
>>> 1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>> index 4c525b3e16ea..0d1414d40f4e 100644
>>> --- a/drivers/vhost/vhost.c
>>> +++ b/drivers/vhost/vhost.c
>>> @@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
>>>
>>> 	for (i = 0; i < dev->nvqs; i++)
>>> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>>> +
>>> +	/*
>>> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>>> +	 * caller that fetched a worker before we cleared the pointers above
>>> +	 * may still be about to queue work on it.  Wait for those RCU readers
>>> +	 * to finish before freeing the worker, then run whatever they queued
>>> +	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
>>> +	 * vhost_worker_killed().
>>> +	 */
>>> +	if (!xa_empty(&dev->worker_xa)) {
>>> +		synchronize_rcu();
>>> +		xa_for_each(&dev->worker_xa, i, worker)
>>> +			vhost_run_work_list(worker);
>>> +	}
>>> +
>>
>> Following sashiko review [1], I tried to undersand why we need this, but
>> TBH I'm really confused. That said, this seems wrong also because it
>> will work only with vhost_tasks, and not with kthreads.
>>
>> IIUC vhost_worker_killed() will be called anyway when calling
>> vhost_worker_destroy(). For vhost_tasks, it will call
>> vhost_task_do_stop() that calls vhost_task_stop(). This sets
>> VHOST_TASK_FLAGS_STOP and wait the worker on vtsk->exited before freeing
>> stuff. The worker breaks the loop and calls vtsk->handle_sigkill() that
>> is exactly vhost_worker_killed() you mentioned we are mirroring here.
>>
>
>Hmm, are we sure it's the case for our codepath?  Looking at the
>vhost_task loop function:
>
>> static int vhost_task_fn(void *data)
>> {
>>     for (;;) {
>>         if (signal_pending(current)) {
>>             if (get_signal(&ksig))
>>                 break;
>>         }
>>         ...
>>         if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>             __set_current_state(TASK_RUNNING);
>>             break;
>>         }
>>         did_work = vtsk->fn(vtsk->data);
>>         ...
>>     }
>>
>>     ...
>>
>>     if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>         set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
>>         vtsk->handle_sigkill(vtsk->data);
>>     }
>>     ...
>> }
>
>AFAICT, we exit the loop in 2 cases: signal delivery or STOP bit
>setting.  Like you said, STOP is set by vhost_task_stop.  E.g. for our
>RESET_OWNER case:
>
>vhost_vsock_reset_owner()
>  vhost_dev_reset_owner()
>    vhost_dev_cleanup()
>      vhost_workers_free()
>        vhost_worker_destroy()
>          vhost_task_stop()  // for vhost_task_ops backend
>            set_bit(VHOST_TASK_FLAGS_STOP)
>
>So, first of all, actual work by .fn() callback is done after the exit
>checks, therefore we skip it - no chance to drain there.
>
>Secondly, the handle_sigkill() callback is deliberately NOT called in
>the STOP case and only called on fatal signal delivery.  And for
>vhost_task backend the .handle_sigkill() callback is exactly
>vhost_worker_killed().
>
>So my understanding is: if we only call synchronize_rcu() here and leave
>this path undrained, then whatever work which was put by send_pkt() for
>the worker currently being freed - will be lost.  Please correct me if
>I'm wrong.

Yep, your right. But what will be the issue of loosing them?

IIUC we are not loosing any data, just avoiding some works that will be 
handled later when/if will set a new owner.

>
>That said, I agree that vhost_run_work_list() will only work with
>vhost_task backend, not with kthreads backend.  If we do
>vhost_worker_flush() instead - I guess it'll keep the drain here, yet
>become backend-agnostic. I.e.:
>
>> +       if (!xa_empty(&dev->worker_xa)) {
>> +               synchronize_rcu();
>> +               xa_for_each(&dev->worker_xa, i, worker)
>> +                       vhost_worker_flush(worker);
>> +       }
>
>With the last 2 lines being equivalent to just calling
>vhost_dev_flush(dev).  And once we become backend-agnostic here, I'm
>guessing the warning reported by Sashiko should be dealt with as well.

I'd avoid `if !xa_empty(&dev->worker_xa)` at all, and call 
synchronize_rcu() in any case.

About vhost_dev_flush(), we are calling it in several places, and maybe 
we should re-check them. E.g. we call in vhost_vsock_flush(), but it's 
also called by vhost_dev_stop(), maybe we can avoid to call 
vhost_vsock_flush() if we call vhost_dev_stop().

I'm not sure we really need another one here, but if you think some 
other works can be queued between the vhost_dev_stop() and the 
synchronize_rcu() we are adding here, then okay, it may have sense.

Thanks,
Stefano

