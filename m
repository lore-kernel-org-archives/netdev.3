Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872721;
	b=Pr2IaOhKjmEuU959hSt1POJan+ueZ+/jShl2baWqSF6oHaHyVU2WRhn8cGF/Tniuzl7o
	 HSyQO9QAsE3PUmjud7hbUm3IRiwAc6Dap7L19voaEncEITrgAHXyVNiurDhdbnQObVqJx
	 HzqOLg0AhEcjRHKxcLCzZ7IKdXZm4SR5chBfAe/Go4b9sVEbdt6sjLLzlX2ZW5h2szFax
	 LNucUPZPWehnMEYmw0VCA/KY4FCGS6ElhkvnuGkrdARSDKbsojsaJH/agqmyLBj9snV6J
	 hEw15Y4AlExpaV/cDSipjS8NYzPW2IdBiLcU0HKuSxJjqBaJFE2nEcibUGziefHwvRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872721;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=muRVNtpHPN8u6TD6ZpfYVyyB4/5pebiG/RBZ2qZUbIA=;
	b=AfE9SFxa595g7hWYZcayBGy2vKnkRicQ6abRprQRYGH+9sArxW5YCrDsD4vuVghpqEmU
	 QsOcGJBZK1N8zn0mJeQe5B1gs3jib5YVxda6xJsRTAokSjilElY3+TA94SlDVYD/ZC1tR
	 TgtsQVGrQXJsRZ0U+eTD4i5ZUGL8OyC8iIA7gIsSDit6WFJogoEs0JS12JqLXbg83aAx3
	 NotZO2U1SJ/KqZFa9e5hFvqwElJXENgPISZo/E6kcxKSbZPq3eN7CsLxHgdd1W9UevP8r
	 GAyxZXDgl5qoRYR14ftkj6tgeN+miHBOLYhBhcd+9werF6eNWuu6oz/mY4mXGWQBojg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTKJMCls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6832606A326;
	Thu,  5 Nov 2026 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTKJMCls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B216F1F000C1;
	Thu,  5 Nov 2026 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793872720;
	bh=muRVNtpHPN8u6TD6ZpfYVyyB4/5pebiG/RBZ2qZUbIA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dTKJMClsYHnp06jclLbts2Q4zCBaBIqZ4Yc2s92swYekKBG1ruRI0th2GBOll7rxl
	 AIeYkYXYfD6x+Porhrg5HdPLmndCLYBDT5WuCYwcXf+oat8DZAtEOiOV1DlnI3hmOn
	 vrWDalfzkPln0aEk6OkFLzwwOLMuMHnR4jCFAoVcmkvSYj7zmTqRrK5D+/Qtzq78Jh
	 Qcgcg8C0Gph8m5XDmKpSScmir+OC+RkO1cdLzSwjEkOb5fM/bXfhiL9Oh6Zt3ZZxbi
	 PxvwGlGFPw93PR0FLhO8xw+KMrEJk00O0+oSbLOpUhi8kLdqaSOTbmSLfGktuWufBS
	 H2ZDSzOSQ+rpQ==
Subject:
 Re: [PATCH] nfc: rawsock: prevent TX work requeue after socket shutdown
From: netdev-bot+sashiko@kernel.org
To: shunsheng1218@gmail.com
Cc: david@ixit.cz, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, lauro.venancio@openbossa.org,
 sameo@linux.intel.com, linville@tuxdriver.com, aloisio.almeida@openbossa.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 05 Nov 2026 09:58:39 +0000
Message-ID: <179387271921.488856.11043838083216323158@kernel.org>
In-Reply-To: <179378590950.74297.14503648624087894519@gmail.com>
References: <179378590950.74297.14503648624087894519@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is still racy, so the use-after-free it claims to close
  remains reachable.
- [Low] The patch only works on top of commit d793458c45df2a ("nfc:
  rawsock: cancel tx_work before socket teardown", 2026-03-03), and the…

--

nfc: rawsock: prevent TX work requeue after socket shutdown

The patch makes rawsock_data_exchange_complete() check SEND_SHUTDOWN
under sk_write_queue.lock before it reschedules tx_work. The goal is to
stop a delayed data-exchange completion from requeueing the work after
rawsock_release() has started tearing the socket down.

> diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
> index f7d7a599fade7..efdbd512d4600 100644
> --- a/net/nfc/rawsock.c
> +++ b/net/nfc/rawsock.c
> @@ -168,7 +168,13 @@ static void rawsock_data_exchange_complete(void *context, struct sk_buff *skb,
>  		goto error_skb;
>  
>  	spin_lock_bh(&sk->sk_write_queue.lock);
> -	if (!skb_queue_empty(&sk->sk_write_queue))
> +	/*
> +	 * The release path sets SEND_SHUTDOWN before cancel_work_sync():
> +	 * once it is set, do not requeue tx_work - the socket may be freed
> +	 * right after the cancel returns.
> +	 */

[Severity: Low]
This comment relies on the SEND_SHUTDOWN / cancel_work_sync() block in
rawsock_release(). That block was added by commit d793458c45df2a ("nfc:
rawsock: cancel tx_work before socket teardown"). Before that commit,
rawsock_release() did not set SEND_SHUTDOWN and did not cancel tx_work.

The patch only carries:

    Fixes: 23b7869c0fd08 ("NFC: add the NFC socket raw protocol")

The lines it changes date back to 2011. It would apply cleanly to a
stable tree that lacks d793458c45df2a, and there the new check would do
nothing during release.

Should this have a Fixes: tag for d793458c45df ("nfc: rawsock: cancel
tx_work before socket teardown"), or at least name it as a prerequisite?

> +	if (!skb_queue_empty(&sk->sk_write_queue) &&
> +	    !(sk->sk_shutdown & SEND_SHUTDOWN))
>  		schedule_work(&nfc_rawsock(sk)->tx_work);

[Severity: High]
Is this check actually serialized with the release path? Only the
completion side takes sk_write_queue.lock here. rawsock_release() sets
the flag and cancels the work without holding that lock:

net/nfc/rawsock.c:rawsock_release() {
    ...
	if (sk->sk_state == TCP_ESTABLISHED) {
		...
		sk->sk_shutdown |= SEND_SHUTDOWN;
		cancel_work_sync(&nfc_rawsock(sk)->tx_work);
		rawsock_write_queue_purge(sk);
	}

	sock_orphan(sk);
	sock_put(sk);
    ...
}

Release only takes the lock later, inside rawsock_write_queue_purge().

Can the following interleaving still happen? CPU0 holds the reference
taken by sock_hold() in rawsock_tx_work():

CPU0 (rawsock_data_exchange_complete)   CPU1 (rawsock_release)
spin_lock_bh(&sk->sk_write_queue.lock)
queue non-empty, sk_shutdown == 0
                                        sk->sk_shutdown |= SEND_SHUTDOWN
                                        cancel_work_sync(&tx_work)
                                          tx_work idle, returns at once
schedule_work(&tx_work) succeeds
spin_unlock_bh()
sock_put(sk)
                                        rawsock_write_queue_purge(sk)
                                        sock_orphan(sk)
                                        sock_put(sk)
                                          last ref, socket freed

If tx_work is neither pending nor running, cancel_work_sync() returns
right away. __cancel_work_sync() also calls enable_work() before it
returns, so the later schedule_work() can still queue the work.

rawsock_destruct() does not cancel tx_work, and the queued work holds no
socket reference. When the worker runs, rawsock_tx_work() would read
freed memory:

	struct sock *sk = to_rawsock_sk(work);
	struct nfc_dev *dev = nfc_rawsock(sk)->dev;
	u32 target_idx = nfc_rawsock(sk)->target_idx;
	...
	if (sk->sk_shutdown & SEND_SHUTDOWN) {

Would it close this window to set SEND_SHUTDOWN under sk_write_queue.lock
in rawsock_release(), before cancel_work_sync()? Then either the
completion sees the flag, or its schedule_work() ran before release took
the lock, and cancel_work_sync() will cancel or wait for that work.

Separately, the unlocked read-modify-write of sk->sk_shutdown in
rawsock_release() races with the plain read here. It also races with the
plain store in rawsock_report_error():

	sk->sk_shutdown = SHUTDOWN_MASK;

KCSAN would likely report this as a data race. The rest of the
networking stack accesses sk_shutdown with READ_ONCE()/WRITE_ONCE().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179378590950.74297.14503648624087894519%40gmail.com
