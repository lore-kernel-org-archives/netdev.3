Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C815C14F;
	Sun, 19 Jul 2026 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468691; cv=none; b=UELLGBSlPc0Z1u0TvLUpQuJnXaoNoI0UD+K+aBBnF3rPkP7UF7Tktk0BNiy4MSBT597oJ5Q6axQX5OUBXFcQ0kX+sBc/5PVdDdusMUJGb9ymn19r7Dd/+xPPtpms6n7rQaAXFL3A7H0aCwM2VGoZ4/LiaRMG7UzCAcGvyocm8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468691; c=relaxed/simple;
	bh=xH1j+RdmJFzOVETMujkStMXFz/ZCaiveNFB3CFpaAeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlSDH795fYZAYuaAKZJAvvPSTjX9TQYNTprUttq7qECm+SrWcvXqJP02a+ZT+OynU+v8DhRa/hWdEsrOJLYGWRBOBI0je9sqgwc09eMOP0P+8vrT2fuJ3fxAFOcipdmnMOJS4pUR4I7mAvgvtdGqBDmPkDRYyeWeKBqEjbvGZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=LihoxV5j; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="LihoxV5j"
Received: from [192.168.1.182] (ip-62-24-73-79.bb.vodafone.cz [62.24.73.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 054DD53401FF;
	Sun, 19 Jul 2026 15:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1784468686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XgKw0JekbDRzrLiWUnHLSoA2gecog6DKGXR64Ihjv9I=;
	b=LihoxV5jKC2zFXDDfIfJQ7iG7KpgvSJ7xy5FYUT3g6LBNQoAhU531eRnFxJhNZ8UQUThbq
	zqV85JNWRIJsvOO9wt5qwJ6YCpriAvPzusmbiVHKYGXs+0/gweyB4suVYd0cNSJy4fioPS
	1T671MhoLnpHQ7oUXOCmCYvJcDbscjk=
Message-ID: <1c2cd3d9-7d97-482c-aced-63bc93faf430@ixit.cz>
Date: Sun, 19 Jul 2026 15:44:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: llcp: Fix nfc_dev refcount leak in connect
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>, oe-linux-nfc@lists.linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260707183518.1888697-1-shuangpeng.kernel@gmail.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260707183518.1888697-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/07/2026 20:35, Shuangpeng Bai wrote:
> llcp_sock_connect() takes a reference to the NFC device with
> nfc_get_device() and stores it in llcp_sock->dev before moving the
> socket to LLCP_CONNECTING.
> 
> If such a pending connection is released before reaching
> LLCP_CONNECTED, llcp_sock_destruct() does not drop that device
> reference because it only handles connected sockets. This leaks the
> nfc_dev reference acquired during connect.
> 
> Drop the device reference for LLCP_CONNECTING sockets as well.
> 
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
>   net/nfc/llcp_sock.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Hello Shuangpeng,

could you check the Sashiko review, if you can address the issue found within 
the patch (the existing code issues are optional to address)?

--- Patch [1]: [PATCH] nfc: llcp: Fix nfc_dev refcount leak in connect ---
commit 84e092575501f812e707c62695cef1ec7ff9d8a6
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

nfc: llcp: Fix nfc_dev refcount leak in connect

llcp_sock_connect() takes a reference to the NFC device with
nfc_get_device() and stores it in llcp_sock->dev before moving the
socket to LLCP_CONNECTING. If such a pending connection is released
before reaching LLCP_CONNECTED, llcp_sock_destruct() does not drop that
device reference because it only handles connected sockets. This leaks the
nfc_dev reference acquired during connect. Drop the device reference for
LLCP_CONNECTING sockets as well.

 > diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
 > index feab29fc62f44..44639ccd438e4 100644
 > --- a/net/nfc/llcp_sock.c
 > +++ b/net/nfc/llcp_sock.c
 > @@ -960,7 +960,8 @@ static void llcp_sock_destruct(struct sock *sk)
 >
 >  	pr_debug("%p\n", sk);
 >
 > -	if (sk->sk_state == LLCP_CONNECTED)
 > +	if (sk->sk_state == LLCP_CONNECTED ||
 > +	    sk->sk_state == LLCP_CONNECTING)

This isn't a bug introduced by this patch, but does llcp_sock_connect()
lack a state check to prevent it from being called on sockets in LLCP_BOUND
or LLCP_LISTEN states?

If a user creates an AF_NFC socket and calls bind(), placing the socket in
the LLCP_BOUND state, it links into the local->sockets list via its sk_node.
If the user then calls connect(), which only checks for LLCP_CONNECTED and
LLCP_CONNECTING states:

net/nfc/llcp_sock.c:llcp_sock_connect() {
     if (sk->sk_state == LLCP_CONNECTED) {
         ret = -EISCONN;
         goto error;
     }
     if (sk->sk_state == LLCP_CONNECTING) {
         ret = -EINPROGRESS;
         goto error;
     }
     ...
}

It proceeds to overwrite llcp_sock->service_name (leaking the previously
allocated string) and calls nfc_llcp_sock_link(&local->connecting_sockets,
sk).

This executes hlist_add_head() on a node (sk->sk_node) that is already part
of another list, thereby corrupting the pointers of both the sockets and
connecting_sockets lists.

 > +		nfc_put_device(llcp_sock->dev);

Can this introduce a kernel panic via a NULL pointer dereference when a
blocking connect() call fails or is interrupted?

In llcp_sock_connect(), if the wait fails or is interrupted by a signal,
execution jumps to the sock_unlink error path:

net/nfc/llcp_sock.c:llcp_sock_connect() {
     sk->sk_state = LLCP_CONNECTING;

     ret = sock_wait_state(sk, LLCP_CONNECTED,
                           sock_sndtimeo(sk, flags & O_NONBLOCK));
     if (ret && ret != -EINPROGRESS)
         goto sock_unlink;
     ...
sock_llcp_nullify:
     llcp_sock->local = NULL;
     llcp_sock->dev = NULL;
}

This error path nullifies llcp_sock->dev and drops the device reference,
but crucially fails to reset sk->sk_state back to LLCP_CLOSED.

When the user subsequently closes the socket, llcp_sock_destruct() is
invoked. The newly added logic checks for LLCP_CONNECTING sockets and
unconditionally calls nfc_put_device(llcp_sock->dev).

Since dev is NULL, nfc_put_device() evaluates &NULL->dev:

include/net/nfc/nfc.h:nfc_put_device() {
     put_device(&dev->dev);
}

This evaluates to a non-zero struct offset and bypasses the internal NULL
check in put_device(), attempting to decrement the reference count of
unmapped memory.

 >
 >  	skb_queue_purge(&sk->sk_receive_queue);
 >
