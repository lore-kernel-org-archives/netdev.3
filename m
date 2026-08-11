Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891263769E0;
	Tue, 11 Aug 2026 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474932; cv=none; b=j6UtZZM45mjWXYjPF4QnLOsWUvtL3puhC0ZYwNdExVBaGBv6UTz5QfZAzIKGKRwW2XhVSIJFZFWE5ZZ1bsdYbJSRIrRg//80gTjOFN0My2jO7/yIphsFRQ8/WMrkyeciJ9JCJmp4jqpj4jEgu+bZzKpfbeP6rcaPjLGFHuHy7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474932; c=relaxed/simple;
	bh=1cLeN1BgelLvqyDQUGUkP5XBpsC5natTD2ItlOj3U/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P07Y3bZBzD84DO+QdT095a86arBNIUgxwNOrpi3U94zZ6A5dDW8C1/JAPXW4r7RPpiiDKwcGAvdd5Cr2Ggz/qk4Jly8HyWkAoKl9hxxuS+BVdntSPilyteKsDbEmqNYwbnddtcF7gO0ViFjqmRrHn9DG/aJisRf5Em+azAwekiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=q5w9y+pN; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="q5w9y+pN"
Received: from [10.0.0.152] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id EB9755340D28;
	Tue, 11 Aug 2026 21:02:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1786474926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rdFkELjn5PZN3i+Q5YPOGMZJZf9pkg+C8SSisil44Ro=;
	b=q5w9y+pNnjplDBMuwC7ruzS0DwNgS6YaqonYJzyifI7+yJdJDcqKwfb/qvCvHykXnZJl06
	PrlKxQnG9KmXdqj5UphHAmZk5/UAtquep+Y7s3dP+VxHgm3PRm70lP+gQYAli6cOG0tFFm
	A8g6HKdqCI04EXuFYZUchClnjhZZJYo=
Message-ID: <016b7162-b633-4561-a003-526c9d9c5f21@ixit.cz>
Date: Tue, 11 Aug 2026 21:02:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nfc: llcp: Fix race condition in accept_queue
 lifecycle
To: Lee Jones <lee@kernel.org>, David Heidelberg <david+nfc@ixit.cz>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Szymon Janc <szymon.janc@tieto.com>,
 Samuel Ortiz <sameo@linux.intel.com>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260601140934.1040144-1-lee@kernel.org>
 <20260811131433.GU2869284@google.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 xsFNBF5v1x4BEADS3EddwsNsvVAI1XF8uQKbdYPY/GhjaSLziwVnbwv5BGwqB1tfXoHnccoA
 9kTgKAbiXG/CiZFhD6l4WCIskQDKzyQN3JhCUIxh16Xyw0lECI7iqoW9LmMoN1dNKcUmCO9g
 lZxQaOl+1bY/7ttd7DapLh9rmBXJ2lKiMEaIpUwb/Nw0d7Enp4Jy2TpkhPywIpUn8CoJCv3/
 61qbvI9y5utB/UhfMAUXsaAgwEJyGPAqHlC0YZjaTwOu+YQUE3AFzhCbksq95CwDz4U4gdls
 dmv9tkATfu2OmzERZQ6vJTehK0Pu4l5KmCAzYg42I9Dy4E6b17x6NncKbcByQFOXMtG0qVUk
 F1yeeOQUHwu+8t3ZDMBUhCkRL/juuoqLmyDWKMc0hKNNeZ9BNXgB8fXkRLWEUfgDXsFyEkKp
 NxUy5bDRlivf6XfExnikk5kj9l2gGlNQwqROti/46bfbmlmc/a2GM4k8ZyalHNEAdwtXYSpP
 8JJmlbQ7hNTLkc3HQLRsIocN5th/ur7pPMz1Beyp0gbE9GcOceqmdZQB80vJ01XDyCAihf6l
 AMnzwpXZsjqIqH9r7T7tM6tVEVbPSwPt4eZYXSoJijEBC/43TBbmxDX+5+3txRaSCRQrG9dY
 k3mMGM3xJLCps2KnaqMcgUnvb1KdTgEFUZQaItw7HyRd6RppewARAQABzSBEYXZpZCBIZWlk
 ZWxiZXJnIDxkYXZpZEBpeGl0LmN6PsLBlAQTAQgAPgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgBYhBNd6Cc/u3Cu9U6cEdGACP8TTSSByBQJl+KksBQkPDaAOAAoJEGACP8TTSSBy6IAQ
 AMqFqVi9LLxCEcUWBn82ssQGiVSDniKpFE/tp7lMXflwhjD5xoftoWOmMYkiWE86t5x5Fsp7
 afALx7SEDz599F1K1bLnaga+budu55JEAYGudD2WwpLJ0kPzRhqBwGFIx8k6F+goZJzxPDsf
 loAtXQE62UvEKa4KRRcZmF0GGoRsgA7vE7OnV8LMeocdD3eb2CuXLzauHAfdvqF50IfPH/sE
 jbzROiAZU+WgrwU946aOzrN8jVU+Cy8XAccGAZxsmPBfhTY5f2VN1IqvfaRdkKKlmWVJWGw+
 ycFpAEJKFRdfcc5PSjUJcALn5C+hxzL2hBpIZJdfdfStn+DWHXNgBeRDiZj1x6vvyaC43RAb
 VXvRzOQfG4EaMVMIOvBjBA/FtIpb1gtXA42ewhvPnd5RVCqD9YYUxsVpJ9d+XsAy7uib3BsV
 W2idAEsPtoqhVhq8bCUs/G4sC2DdyGZK8MRFDJqciJSUbqA+5z1ZCuE8UOPDpZKiW6H/OuOM
 zDcjh0lOzr4p+/1TSg1PbUh7fQ+nbMuiT044sC1lLtJK0+Zyn0GwhR82oNM4fldNsaHRW42w
 QGD35+eNo5Pvb3We5XRMlBdhFnj7Siggp4J8/PJ6MJvRyC+RIJPGtbdMB2/RxWunFLn87e5w
 UgwR9jPMHAstuTR1yR23c4SIYoQ2fzkrRzuazsFNBF5v1x4BEADnlrbta2WL87BlEOotZUh0
 zXANMrNV15WxexsirLetfqbs0AGCaTRNj+uWlTUDJRXOVIwzmF76Us3I2796+Od2ocNpLheZ
 7EIkq8budtLVd1c06qJ+GMraz51zfgSIazVInNMPk9T6fz0lembji5yEcNPNNBA4sHiFmXfo
 IhepHFOBApjS0CiOPqowYxSTPe/DLcJ/LDwWpTi37doKPhBwlHev1BwVCbrLEIFjY0MLM0aT
 jiBBlyLJaTqvE48gblonu2SGaNmGtkC3VoQUQFcVYDXtlL9CVbNo7BAt5gwPcNqEqkUL60Jh
 FtvVSKyQh6gn7HHsyMtgltjZ3NKjv8S3yQd7zxvCn79tCKwoeNevsvoMq/bzlKxc9QiKaRPO
 aDj3FtW7R/3XoKJBY8Hckyug6uc2qYWRpnuXc0as6S0wfek6gauExUttBKrtSbPPHiuTeNHt
 NsT4+dyvaJtQKPBTbPHkXpTO8e1+YAg7kPj3aKFToE/dakIh8iqUHLNxywDAamRVn8Ha67WO
 AEAA3iklJ49QQk2ZyS1RJ2Ul28ePFDZ3QSr9LoJiOBZv9XkbhXS164iRB7rBZk6ZRVgCz3V6
 hhhjkipYvpJ/fpjXNsVL8jvel1mYNf0a46T4QQDQx4KQj0zXJbC2fFikAtu1AULktF4iEXEI
 rSjFoqhd4euZ+QARAQABwsF8BBgBCAAmAhsMFiEE13oJz+7cK71TpwR0YAI/xNNJIHIFAmX4
 qVAFCQ8NoDIACgkQYAI/xNNJIHKN4A/+Ine2Ii7JiuGITjJkcV6pgKlfwYdEs4eFD1pTRb/K
 5dprUz3QSLP41u9OJQ23HnESMvn31UENk9ffebNoW7WxZ/8cTQY0JY/cgTTrlNXtyAlGbR3/
 3Q/VBJptf04Er7I6TaKAmqWzdVeKTw33LljpkHp02vrbOdylb4JQG/SginLV9purGAFptYRO
 8JNa2J4FAQtQTrfOUjulOWMxy7XRkqK3QqLcPW79/CFn7q1yxamPkpoXUJq9/fVjlhk7P+da
 NYQpe4WQQnktBY29SkFnvfIAwqIVU8ix5Oz8rghuCcAdR7lEJ7hCX9bR0EE05FOXdZy5FWL9
 GHvFa/Opkq3DPmFl/0nt4HJqq1Nwrr+WR6d0414oo1n2hPEllge/6iD3ZYwptTvOFKEw/v0A
 yqOoYSiKX9F7Ko7QO+VnYeVDsDDevKic2T/4GDpcSVd9ipiKxCQvUAzKUH7RUpqDTa+rYurm
 zRKcgRumz2Tc1ouHj6qINlzEe3a5ldctIn/dvR1l2Ko7GBTG+VGp9U5NOAEkGpxHG9yg6eeY
 fFYnMme51H/HKiyUlFiE3yd5LSmv8Dhbf+vsI4x6BOOOq4Iyop/Exavj1owGxW0hpdUGcCl1
 ovlwVPO/6l/XLAmSGwdnGqok5eGZQzSst0tj9RC9O0dXO1TZocOsf0tJ8dR2egX4kxM=
In-Reply-To: <20260811131433.GU2869284@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 15:14, Lee Jones wrote:
> [INTENTIONAL TOP POST]
> 
> This one has been knocking around for a very long time.
> 
> Would you like me to [RESEND] it, or does everyone still have it?
> 
Hello Lee,

sorry, I've must missed the patch. Could you check the Sashiko comments (below)?

Feel free to ignore the pre-existing issue, the main complaint is about the 
description.

Thank you
David

commit 74abfc44e401a556abde5003d20ce7cf50ee958d
Author: Lee Jones <lee@kernel.org>

nfc: llcp: Fix race condition in accept_queue lifecycle

This commit attempts to fix a race condition between nfc_llcp_socket_release()
and nfc_llcp_accept_dequeue() by replacing bh_lock_sock() with lock_sock()
and lock_sock_nested(). It also introduces a socket popping helper and
adds a parent check in nfc_llcp_accept_unlink().

 > nfc_llcp_socket_release() walks the local sockets list and the listener
 > socket's accept_queue under bh_lock_sock().  However, bh_lock_sock()
 > does not provide mutual exclusion against process-context lock_sock()
 > held by nfc_llcp_accept_dequeue() during accept().  Since socket_release()
 > runs in process context (workqueue or kref cleanup), it never checks

Is this description accurate?

nfc_llcp_data_received() routinely runs from softirq/interrupt context
via URB completion handlers like pn533_recv_response(). When it drops
the last reference via nfc_llcp_local_put(), this triggers local_cleanup()
and nfc_llcp_socket_release().

Could this lead to a sleeping in atomic bug since lock_sock() acquires
a mutex?

 > sock_owned_by_user(), allowing both paths to manipulate the same child
 > socket concurrently.  This leads to a double sock_put() (Use-After-Free)
 > or a NULL pointer dereference of child->parent in nfc_llcp_accept_unlink().

[ ... ]

 > diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
 > index dc65c719f35f2..e51bd0d081b62 100644
 > --- a/net/nfc/llcp_core.c
 > +++ b/net/nfc/llcp_core.c
 > @@ -63,21 +63,33 @@ static void nfc_llcp_socket_purge(struct nfc_llcp_sock *sock)
 >  	}
 >  }
 >
[ ... ]
 > @@ -92,7 +104,8 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local 
*local, bool device,
 > -	sk_for_each_safe(sk, tmp, &local->sockets.head) {
 > +	while ((sk = nfc_llcp_sock_list_pop(&local->sockets))) {
 >  		llcp_sock = nfc_llcp_sock(sk);
 >
 > -		bh_lock_sock(sk);
 > +		lock_sock(sk);

Since nfc_llcp_socket_release() can be invoked from softirq teardown paths,
does calling lock_sock() here cause a sleeping in atomic bug because it
acquires a mutex?

[ ... ]
 >  						 &llcp_sock->accept_queue,
 >  						 accept_queue) {
 >  				accept_sk = &lsk->sk;
 > -				bh_lock_sock(accept_sk);
 > +				lock_sock_nested(accept_sk,
 > +						 SINGLE_DEPTH_NESTING);

Does this nested lock_sock_nested() also cause a sleep in atomic context
when nfc_llcp_socket_release() is invoked from softirq teardown paths?

 >  				nfc_llcp_accept_unlink(accept_sk);

This isn't a bug introduced by this patch, but does this leak the initial
sk_alloc reference count?

Sockets created for incoming connections receive an initial sk_alloc
reference. When the listener is closed, unaccepted child sockets are
unlinked here and their list references are dropped.

Since they were never accepted by userspace, sock_release() is never called.
Do these unaccepted sockets permanently leak?

[ ... ]
 > @@ -135,12 +143,9 @@ static void nfc_llcp_socket_release(struct 
nfc_llcp_local *local, bool device,
 >  		sk->sk_state = LLCP_CLOSED;
 >  		sk->sk_state_change(sk);
 >
 > -		bh_unlock_sock(sk);
 > -
 > -		sk_del_node_init(sk);
 > +		release_sock(sk);
 > +		sock_put(sk);
 >  	}
 > -
 > -	write_unlock(&local->raw_sockets.lock);
 >  }
 >
 >  static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)

This isn't a bug introduced by this patch, but is it possible for a dying
object to be resurrected here?

If local_release() runs local_cleanup(), it purges sockets via
nfc_llcp_socket_release() and then waits for rx_work via cancel_work_sync().

If rx_work executes concurrently, it calls nfc_llcp_local_get() which uses
kref_get() without checking for zero. Can rx_work then allocate and link a
new socket just before local is freed, leading to a Use-After-Free?

 > diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
 > index feab29fc62f44..3d30f0233b986 100644
 > --- a/net/nfc/llcp_sock.c
 > +++ b/net/nfc/llcp_sock.c
[ ... ]
 > @@ -622,7 +623,7 @@ static int llcp_sock_release(struct socket *sock)
 >  		list_for_each_entry_safe(lsk, n, &llcp_sock->accept_queue,
 >  					 accept_queue) {
 >  			accept_sk = &lsk->sk;
 > -			lock_sock(accept_sk);
 > +			lock_sock_nested(accept_sk, SINGLE_DEPTH_NESTING);
 >
 >  			nfc_llcp_send_disconnect(lsk);
 >  			nfc_llcp_accept_unlink(accept_sk);

This isn't a bug introduced by this patch, but as mentioned above, does
unlinking unaccepted child sockets here permanently leak their initial
reference count?

This isn't a bug introduced by this patch, but can the blocking loop in
llcp_sock_accept() hang indefinitely?

If the listener socket is shut down or released concurrently, the thread
wakes up but doesn't check sk->sk_state:

llcp_sock_accept() {
     ...
     while (!(new_sk = nfc_llcp_accept_dequeue(sk, newsock))) {
         set_current_state(TASK_INTERRUPTIBLE);
         ...
         release_sock(sk);
         timeo = schedule_timeout(timeo);
         lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
     }
     ...
}

Will it just go back to sleep waiting for a closed socket if no new
socket was dequeued?
