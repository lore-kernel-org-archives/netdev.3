Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E33ACEF8;
	Thu,  8 Oct 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476015; cv=none; b=Dul8fC2SvS4o7Wey7ZRTKtnlvscG+gVHlNwl4Cs+D97ZqvoKMb8tKkpQKNgVhosaYyd4Hdn+ctR246NGz6K5GSnp/iWqK8vqnvgG8yDYMXrgMOSFSlS7O+VT4mz+QHp/Ag1za45UBg2NU5NoIpL8HLi5PwHtBJnLlEoCtS/9hM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476015; c=relaxed/simple;
	bh=jOhwEjDszWu6B0NVc5e0lI5eiTeOgS1ikdmfZhVzeGg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fp0n8OLaNkHjoG2QuEHoNA3hv0Ja7lsQuVRBs2nvlaFiGC0TGdMazgZPsnQc67gebvX8j59QFNrPnBnraUBZ1Iu21AomIof5nG4Z9rdWb69pU8K5BtatHM9eSIL6qEOKr7wvjI/JHOh8xhNVbtJlL/UOkAup5NCSr9M5hggFMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fahdS90s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fahdS90s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3421F000FF;
	Thu,  8 Oct 2026 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476011;
	bh=JbLkU2SW7mx5qB8vilNtsDYGvT1jz11GrW21EhPz+Fo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fahdS90sU0oKW0Rq3/YCOA/y6dpZRE9bOLsSDT4dzETMCZ41MhanAiNOwhcrw2hXR
	 okYF+Xg2ufbhPxuHrDQrxMVplIpiktBGuE1ECa8bM3P73qSX1ieSd4e5SGvMdogS8E
	 kyS6ZCPa2qSoLDPreK6XkNZnF/M2lZW3DfobB6igu7kgJpovVGASroV1bghw1Us5pC
	 vHGmsyOAbBoL8EuoxsJVEP9T8nsUcYxoFy5OumAnmwshvoPBLA2U0GMTFeojZJS/0G
	 KfbFFmm8ihOzAlyFqlMhONnWjbvKksv4e+ucjND0FsYGXYjbsTl/6XxHC+7Z9ckOml
	 Wa63x6m/wf4ag==
Subject: Re: [PATCH net v12 12/15] rxrpc: Fix packet encryption error handling
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
Date: Thu, 08 Oct 2026 16:13:30 +0000
Message-ID: <179147601018.434549.6507092323756978318@kernel.org>
In-Reply-To: <20261006133011.531806-13-dhowells@redhat.com>
References: <20261006133011.531806-13-dhowells@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] rxrpc_send_data() (net/rxrpc/sendmsg.c:460-468) treats every
  -ENOMEM from ->secure_packet() as "encryption hasn't happened yet".

--

rxrpc: Fix packet encryption error handling

This changes rxrpc_send_data() so that -ENOMEM from ->secure_packet() is
treated as retryable. When the failing packet was the final one, the last
append is rewound. Any other error sets a new RXRPC_CALL_TX_ERROR flag, which
makes later sendmsg() calls on the call fail with -EIO.

Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index dff166ff78eb1..072237f5e17a0 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c

[ ... ]

> @@ -443,14 +452,29 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  		/* add the packet to the send queue if it's now full */
>  		if (!txb->space ||
>  		    (len == 0 && !more)) {
> -			if (len == 0 && !more)
> -				txb->flags |= RXRPC_LAST_PACKET;
> -
> +			/* Do any required crypto.  If this fails, it could
> +			 * have corrupted the txbuf content with a partial
> +			 * encrypt.  Assume that ENOMEM is retryable, but
> +			 * everything else is terminal.
> +			 */
>  			ret = call->security->secure_packet(call, txb);
> -			if (ret < 0)
> +			if (ret < 0) {
> +				/* Assume that ENOMEM here means that the
> +				 * encryption hasn't happened yet.  The data is
> +				 * aligned to avoid the need for slow buffering
> +				 * in the crypto walk.
> +				 */
> +				if (ret == -ENOMEM)
> +					goto maybe_error_rewind;
> +				set_bit(RXRPC_CALL_TX_ERROR, &call->flags);

[Severity: High]
Is it safe to assume that -ENOMEM from ->secure_packet() means none of the
txbuf has been encrypted yet?

For rxgk at RXRPC_SECURITY_ENCRYPT, rxgk_secure_packet_encrypted()
encrypts txb->data in place. It returns any -ENOMEM from the crypto layer
unchanged:

rxgk_secure_packet_encrypted()
  crypto_krb5_encrypt()
    krb5_aead_encrypt()
      crypto_aead_encrypt()    /* src == dst, request flags 0 */
        ... cts(cbc(aes))

The AES-NI and ARM32 CE drivers have their own cts_cbc_encrypt(). It
encrypts the CBC prefix in place first, then runs a second walk over the
CTS tail:

arch/x86/crypto/aesni-intel_glue.c:cts_cbc_encrypt() {
    ...
	err = cbc_encrypt(&subreq);
    ...
	err = skcipher_walk_virt(&walk, &subreq, false);
	if (err)
		return err;
    ...
}

With CONFIG_HIGHMEM, scatterwalk_clamp() limits each walk segment to the
current 4K page. Txbufs come from __page_frag_alloc_align() inside a
higher-order page, so the CTS tail can straddle a 4K boundary. When it does,
the walk falls back to skcipher_next_slow():

crypto/skcipher.c:skcipher_next_slow() {
    ...
	buffer = kzalloc(n, skcipher_walk_gfp(walk));
	if (!buffer)
		return skcipher_walk_done(walk, -ENOMEM);
    ...
}

krb5_aead_encrypt() passes request flags of 0, so this kzalloc() uses
GFP_ATOMIC. It can fail after the prefix has already been turned into
ciphertext. In that setup, the comment about the data being aligned to avoid
slow buffering doesn't seem to hold.

The rewind in maybe_error_rewind doesn't seem to help in this case:

	if (rewind_by && !more && !len) {

Suppose the txbuf filled up (txb->space == 0) with len > 0 left, or
MSG_MORE is set. Then nothing is rewound and a positive short count is
returned. The next sendmsg() copies nothing into the full tx_pending and
calls ->secure_packet() again on the partly encrypted buffer.

Now suppose the txbuf already held data from an earlier MSG_MORE sendmsg(),
as with AFS sending a header and then a body. Only the latest append is
rewound, so the earlier bytes in the encrypted prefix are left as
ciphertext.

On retry, that prefix gets encrypted a second time. krb5enc computes its
checksum over this mixed plaintext. authenc computes its MAC over the
resulting ciphertext. Either way, wouldn't the peer verify the packet and
accept the corrupted payload?

The commit message says the problem is that a retry "might succeed with a
corrupt buffer". Should -ENOMEM from the encryption step also set
RXRPC_CALL_TX_ERROR? Alternatively, could retryability depend on whether
the in-place transform has started?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006133011.531806-1-dhowells%40redhat.com
