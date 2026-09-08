Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E14E13E1;
	Tue,  8 Sep 2026 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863390; cv=none; b=prJF0BiuhEryKgVgx+4ohQRic+lf0gGnkOR386O4mMXul4w0SF8bzARIsq206/YtuWUO8BodXpq3QavjWjJWzgOG/ImJ04G7lqbJ9EZ4kUi4M8SsvgcRR5feSW9Ce559HJ/NhPDnNpTbU4RoZCwIYUy9rjuxPQw3iPMWBPwJ30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863390; c=relaxed/simple;
	bh=EF+Z5H/5U9fHrEmrowNhro8b2gwSEzL9TSiN4IdPAgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nLYWQrG7ud/TGAvulbCB4H39EWKQm1BS/JBWpd75KyWmUvzwuVuAu2MkaVGbL3HxvDaWuyQKZEZoEgG08YWIzwYFXj27zpRUObELNNrCIYYROVXX1N4rRp7ndsyS/u+kqiRaVJU6MbzfGjywPjC69V6Hx0Fmc5xlbcLiRRCa1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=JSOPeS8V; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="JSOPeS8V"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 0876A5340A28;
	Tue, 08 Sep 2026 12:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1788863379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LUEO9MSutUlckEuDJl3NbKDloD/jmqfYo5lp1eUUhBQ=;
	b=JSOPeS8VEmGDg2lMQc8aechj9CwlLGiJzBlaomtjhC8vchdQIcDcNB1SoZL4qSVO01j96F
	myjjBhDs3xp/HDx++F+XP6KbZDquMgejbjlobFGoA+jf4ZNywNwEyCUzEmlpkpfIaAPEMK
	VAM3vp0uojmf0YnBYGO2ePc5wLAMrS8=
Message-ID: <6beddcea-bc04-471d-be5d-8e391cdedee3@ixit.cz>
Date: Tue, 8 Sep 2026 12:29:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nfc: llcp: Fix race condition in accept_queue
 lifecycle
To: Lee Jones <lee@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Szymon Janc <szymon.janc@tieto.com>,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902123033.1169067-1-lee@kernel.org>
 <20260908080638.GY2133376@google.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260908080638.GY2133376@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Lee,

thank you. Yes, it's.

David

On 08/09/2026 10:06, Lee Jones wrote:
> [INTENTIONAL TOP-POST]
> 
> Good morning David,
> 
> Just checking that this is on your radar this time [0].
> 
> Please let me know if you'd prefer a [RESEND].
> 
> [0] https://lore.kernel.org/all/016b7162-b633-4561-a003-526c9d9c5f21@ixit.cz/
> 
> Kind regards,
> Lee
> 
>> In nfc_llcp_socket_release(), sockets and listener accept queues are
>> walked under the local sockets rwlock and bh_lock_sock().  However,
>> bh_lock_sock() does not synchronise against process-context lock_sock()
>> held by nfc_llcp_accept_dequeue() during accept().  Because
>> socket_release() does not check sock_owned_by_user(), both paths can
>> concurrently unlink and release the same child socket, resulting in
>> use-after-free or a NULL pointer dereference of child->parent in
>> nfc_llcp_accept_unlink().
>>
>> Fix this synchronisation race by having nfc_llcp_socket_release() use
>> process-context lock_sock() instead of bh_lock_sock():
>>
>> 1. Pop sockets from the local sockets list under the write lock using
>>     nfc_llcp_sock_list_pop() so lock_sock() can be acquired without
>>     holding the rwlock.
>>
>> 2. Because lock_sock() can sleep, defer the final release of the
>>     nfc_llcp_local structure to a workqueue (release_work).  This avoids
>>     a sleeping-in-atomic bug when the last local reference is dropped
>>     from softirq context.  Additionally, hold a single device reference
>>     on local from registration until final destruction.
>>
>> 3. In nfc_llcp_local_get(), use kref_get_unless_zero() to prevent
>>     resurrecting a local object whose teardown has been scheduled.
>>
>> 4. In llcp_sock_accept(), verify that the listener socket state is still
>>     LLCP_LISTEN after waking from schedule_timeout() to prevent hangs if
>>     the listener is closed concurrently.
>>
>> 5. When unlinking unaccepted child sockets during listener release,
>>     unlink them from local->sockets, call sock_orphan(), and drop their
>>     initial sk_alloc creation reference via sock_put().
>>
>> 6. Make nfc_llcp_accept_unlink() idempotent by guarding parent access with
>>     a NULL check.
>>
>> Fixes: 50b78b2a6500 ("NFC: Fix sleeping in atomic when releasing socket")
>> Signed-off-by: Lee Jones <lee@kernel.org>
>> ---
>>
>> v1 -> v2:
>> - Defer local release to dedicated workqueue (llcp_wq) to avoid sleeping in atomic
>> - Drain and destroy llcp_wq on module unload to prevent module exit race
>> - Drop initial sk_alloc creation ref on unaccepted child sockets across all teardown paths
>> - Use kref_get_unless_zero() in local_get to prevent resurrecting dying local objects
>> - Check listener socket state after waking in llcp_sock_accept() to avoid hangs
>> - Standardise Parent (0) -> Child (1) lockdep subclass nesting
>>
>> v2 -> v3:
>> - Allocate dedicated workqueue (llcp_wq) with WQ_UNBOUND to fix syzbot warning
>>
>>   net/nfc/llcp.h      |   1 +
>>   net/nfc/llcp_core.c | 123 +++++++++++++++++++++++++++-----------------
>>   net/nfc/llcp_sock.c |  49 +++++++++++++-----
>>   3 files changed, 115 insertions(+), 58 deletions(-)
>>
>> diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
>> index d8345ed57c95..23ae7a0112d3 100644
>> --- a/net/nfc/llcp.h
>> +++ b/net/nfc/llcp.h
>> @@ -91,6 +91,7 @@ struct nfc_llcp_local {
>>   	struct hlist_head pending_sdreqs;
>>   	struct timer_list sdreq_timer;
>>   	struct work_struct sdreq_timeout_work;
>> +	struct work_struct release_work;
>>   	u8 sdreq_next_tid;
>>   
>>   	/* sockets array */
>> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
>> index bd6361e2efa4..23553e7426ec 100644
>> --- a/net/nfc/llcp_core.c
>> +++ b/net/nfc/llcp_core.c
>> @@ -20,6 +20,8 @@ static LIST_HEAD(llcp_devices);
>>   /* Protects llcp_devices list */
>>   static DEFINE_SPINLOCK(llcp_devices_lock);
>>   
>> +static struct workqueue_struct *llcp_wq;
>> +
>>   static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb);
>>   
>>   void nfc_llcp_sock_link(struct llcp_sock_list *l, struct sock *sk)
>> @@ -63,21 +65,33 @@ static void nfc_llcp_socket_purge(struct nfc_llcp_sock *sock)
>>   	}
>>   }
>>   
>> +static struct sock *nfc_llcp_sock_list_pop(struct llcp_sock_list *l)
>> +{
>> +	struct sock *sk;
>> +
>> +	write_lock(&l->lock);
>> +	sk = sk_head(&l->head);
>> +	if (sk) {
>> +		sock_hold(sk);
>> +		sk_del_node_init(sk);
>> +	}
>> +	write_unlock(&l->lock);
>> +
>> +	return sk;
>> +}
>> +
>>   static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>>   				    int err)
>>   {
>>   	struct sock *sk;
>> -	struct hlist_node *tmp;
>>   	struct nfc_llcp_sock *llcp_sock;
>>   
>>   	skb_queue_purge(&local->tx_queue);
>>   
>> -	write_lock(&local->sockets.lock);
>> -
>> -	sk_for_each_safe(sk, tmp, &local->sockets.head) {
>> +	while ((sk = nfc_llcp_sock_list_pop(&local->sockets))) {
>>   		llcp_sock = nfc_llcp_sock(sk);
>>   
>> -		bh_lock_sock(sk);
>> +		lock_sock(sk);
>>   
>>   		nfc_llcp_socket_purge(llcp_sock);
>>   
>> @@ -91,17 +105,27 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>>   			list_for_each_entry_safe(lsk, n,
>>   						 &llcp_sock->accept_queue,
>>   						 accept_queue) {
>> +				bool put_creation = false;
>> +
>>   				accept_sk = &lsk->sk;
>> -				bh_lock_sock(accept_sk);
>> +				lock_sock_nested(accept_sk,
>> +						 SINGLE_DEPTH_NESTING);
>>   
>> -				nfc_llcp_accept_unlink(accept_sk);
>> +				if (nfc_llcp_sock(accept_sk)->parent == sk) {
>> +					nfc_llcp_accept_unlink(accept_sk);
>> +					nfc_llcp_sock_unlink(&local->sockets, accept_sk);
>>   
>> -				if (err)
>> -					accept_sk->sk_err = err;
>> -				accept_sk->sk_state = LLCP_CLOSED;
>> -				accept_sk->sk_state_change(sk);
>> +					if (err)
>> +						accept_sk->sk_err = err;
>> +					accept_sk->sk_state = LLCP_CLOSED;
>> +					accept_sk->sk_state_change(accept_sk);
>> +					sock_orphan(accept_sk);
>> +					put_creation = true;
>> +				}
>>   
>> -				bh_unlock_sock(accept_sk);
>> +				release_sock(accept_sk);
>> +				if (put_creation)
>> +					sock_put(accept_sk); /* creation ref */
>>   			}
>>   		}
>>   
>> @@ -110,23 +134,18 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>>   		sk->sk_state = LLCP_CLOSED;
>>   		sk->sk_state_change(sk);
>>   
>> -		bh_unlock_sock(sk);
>> -
>> -		sk_del_node_init(sk);
>> +		release_sock(sk);
>> +		sock_put(sk);
>>   	}
>>   
>> -	write_unlock(&local->sockets.lock);
>> -
>>   	/* If we still have a device, we keep the RAW sockets alive */
>>   	if (device == true)
>>   		return;
>>   
>> -	write_lock(&local->raw_sockets.lock);
>> -
>> -	sk_for_each_safe(sk, tmp, &local->raw_sockets.head) {
>> +	while ((sk = nfc_llcp_sock_list_pop(&local->raw_sockets))) {
>>   		llcp_sock = nfc_llcp_sock(sk);
>>   
>> -		bh_lock_sock(sk);
>> +		lock_sock(sk);
>>   
>>   		nfc_llcp_socket_purge(llcp_sock);
>>   
>> @@ -135,26 +154,20 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>>   		sk->sk_state = LLCP_CLOSED;
>>   		sk->sk_state_change(sk);
>>   
>> -		bh_unlock_sock(sk);
>> -
>> -		sk_del_node_init(sk);
>> +		release_sock(sk);
>> +		sock_put(sk);
>>   	}
>> -
>> -	write_unlock(&local->raw_sockets.lock);
>>   }
>>   
>>   static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
>>   {
>> -	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
>> -	 * we hold a reference to local, we also need to hold a reference to
>> -	 * the device to avoid UAF.
>> -	 */
>> -	if (!nfc_get_device(local->dev->idx))
>> +	if (!local)
>>   		return NULL;
>>   
>> -	kref_get(&local->ref);
>> +	if (kref_get_unless_zero(&local->ref))
>> +		return local;
>>   
>> -	return local;
>> +	return NULL;
>>   }
>>   
>>   static void local_cleanup(struct nfc_llcp_local *local)
>> @@ -172,30 +185,34 @@ static void local_cleanup(struct nfc_llcp_local *local)
>>   	nfc_llcp_free_sdp_tlv_list(&local->pending_sdreqs);
>>   }
>>   
>> +static void local_release_work(struct work_struct *work)
>> +{
>> +	struct nfc_llcp_local *local;
>> +	struct nfc_dev *dev;
>> +
>> +	local = container_of(work, struct nfc_llcp_local, release_work);
>> +	dev = local->dev;
>> +
>> +	local_cleanup(local);
>> +	kfree(local);
>> +	nfc_put_device(dev);
>> +}
>> +
>>   static void local_release(struct kref *ref)
>>   {
>>   	struct nfc_llcp_local *local;
>>   
>>   	local = container_of(ref, struct nfc_llcp_local, ref);
>>   
>> -	local_cleanup(local);
>> -	kfree(local);
>> +	queue_work(llcp_wq, &local->release_work);
>>   }
>>   
>>   int nfc_llcp_local_put(struct nfc_llcp_local *local)
>>   {
>> -	struct nfc_dev *dev;
>> -	int ret;
>> -
>> -	if (local == NULL)
>> +	if (!local)
>>   		return 0;
>>   
>> -	dev = local->dev;
>> -
>> -	ret = kref_put(&local->ref, local_release);
>> -	nfc_put_device(dev);
>> -
>> -	return ret;
>> +	return kref_put(&local->ref, local_release);
>>   }
>>   
>>   static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
>> @@ -1705,6 +1722,7 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
>>   	INIT_WORK(&local->rx_work, nfc_llcp_rx_work);
>>   
>>   	INIT_WORK(&local->timeout_work, nfc_llcp_timeout_work);
>> +	INIT_WORK(&local->release_work, local_release_work);
>>   
>>   	rwlock_init(&local->sockets.lock);
>>   	rwlock_init(&local->connecting_sockets.lock);
>> @@ -1748,10 +1766,23 @@ void nfc_llcp_unregister_device(struct nfc_dev *dev)
>>   
>>   int __init nfc_llcp_init(void)
>>   {
>> -	return nfc_llcp_sock_init();
>> +	int ret;
>> +
>> +	llcp_wq = alloc_workqueue("nfc_llcp_wq", WQ_UNBOUND, 0);
>> +	if (!llcp_wq)
>> +		return -ENOMEM;
>> +
>> +	ret = nfc_llcp_sock_init();
>> +	if (ret) {
>> +		destroy_workqueue(llcp_wq);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>>   void nfc_llcp_exit(void)
>>   {
>>   	nfc_llcp_sock_exit();
>> +	destroy_workqueue(llcp_wq);
>>   }
>> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
>> index 5558d8a4d48b..ce6875eb58fb 100644
>> --- a/net/nfc/llcp_sock.c
>> +++ b/net/nfc/llcp_sock.c
>> @@ -392,11 +392,12 @@ void nfc_llcp_accept_unlink(struct sock *sk)
>>   
>>   	pr_debug("state %d\n", sk->sk_state);
>>   
>> -	list_del_init(&llcp_sock->accept_queue);
>> -	sk_acceptq_removed(llcp_sock->parent);
>> -	llcp_sock->parent = NULL;
>> -
>> -	sock_put(sk);
>> +	if (llcp_sock->parent) {
>> +		list_del_init(&llcp_sock->accept_queue);
>> +		sk_acceptq_removed(llcp_sock->parent);
>> +		llcp_sock->parent = NULL;
>> +		sock_put(sk);
>> +	}
>>   }
>>   
>>   void nfc_llcp_accept_enqueue(struct sock *parent, struct sock *sk)
>> @@ -423,12 +424,20 @@ struct sock *nfc_llcp_accept_dequeue(struct sock *parent,
>>   
>>   	list_for_each_entry_safe(lsk, n, &llcp_parent->accept_queue,
>>   				 accept_queue) {
>> +		struct nfc_llcp_local *local;
>> +
>>   		sk = &lsk->sk;
>> -		lock_sock(sk);
>> +		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>>   
>>   		if (sk->sk_state == LLCP_CLOSED) {
>> -			release_sock(sk);
>> +			local = nfc_llcp_sock(sk)->local;
>> +
>>   			nfc_llcp_accept_unlink(sk);
>> +			if (local)
>> +				nfc_llcp_sock_unlink(&local->sockets, sk);
>> +			sock_orphan(sk);
>> +			release_sock(sk);
>> +			sock_put(sk);
>>   			continue;
>>   		}
>>   
>> @@ -464,7 +473,7 @@ static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
>>   
>>   	pr_debug("parent %p\n", sk);
>>   
>> -	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>> +	lock_sock(sk);
>>   
>>   	if (sk->sk_state != LLCP_LISTEN) {
>>   		ret = -EBADFD;
>> @@ -490,7 +499,12 @@ static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
>>   
>>   		release_sock(sk);
>>   		timeo = schedule_timeout(timeo);
>> -		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
>> +		lock_sock(sk);
>> +
>> +		if (sk->sk_state != LLCP_LISTEN) {
>> +			ret = -EBADFD;
>> +			break;
>> +		}
>>   	}
>>   	__set_current_state(TASK_RUNNING);
>>   	remove_wait_queue(sk_sleep(sk), &wait);
>> @@ -629,13 +643,24 @@ static int llcp_sock_release(struct socket *sock)
>>   
>>   		list_for_each_entry_safe(lsk, n, &llcp_sock->accept_queue,
>>   					 accept_queue) {
>> +			bool put_creation = false;
>> +
>>   			accept_sk = &lsk->sk;
>> -			lock_sock(accept_sk);
>> +			lock_sock_nested(accept_sk, SINGLE_DEPTH_NESTING);
>>   
>> -			nfc_llcp_send_disconnect(lsk);
>> -			nfc_llcp_accept_unlink(accept_sk);
>> +			if (nfc_llcp_sock(accept_sk)->parent == sk) {
>> +				nfc_llcp_send_disconnect(lsk);
>> +				nfc_llcp_accept_unlink(accept_sk);
>> +				nfc_llcp_sock_unlink(&local->sockets, accept_sk);
>> +
>> +				accept_sk->sk_state = LLCP_CLOSED;
>> +				sock_orphan(accept_sk);
>> +				put_creation = true;
>> +			}
>>   
>>   			release_sock(accept_sk);
>> +			if (put_creation)
>> +				sock_put(accept_sk); /* creation ref */
>>   		}
>>   	}
>>   
>> -- 
>> 2.55.0.966.g6673acef38-goog
>>
> 

