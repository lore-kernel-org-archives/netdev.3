Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048302D876B;
	Tue, 24 Feb 2026 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771976995; cv=none; b=WjgtAgBStRRwAR6RJW763YLpjBChzipDWcDPNvSSQPMGKBcd/r9m7CSVXe9TnQUueV+2i1QdiWlI5oPghTRQYgGoMJ8tZU/H21370EDtETG2DRJDkRKG2uZ7cmazWltr+UdS5kRlSOuqY9c6Fl5dkRzbAuzRdYbCcJbod2mDXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771976995; c=relaxed/simple;
	bh=FGGuPZNGyCWAYKXaCUE/N/nQdSlJWii9ITxMe7XO4K4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZ+/jsB61xNFqO049CbNajF9uHxQ1dS9W8vt34NoPyivNJ1QbNKmOomEM7S3m8dgWXAP2USZBgJ58acwWQBp8OfPaFNCHycJwzwbA8NJhQ+FDNXwAaj24jE7qFxPvA9VAwuUFnHQjmYK5q7PEYyr25rJO7RRQgKt+btIFV7CdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0VwyV2g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0VwyV2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2971C19423;
	Tue, 24 Feb 2026 23:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771976994;
	bh=FGGuPZNGyCWAYKXaCUE/N/nQdSlJWii9ITxMe7XO4K4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s0VwyV2gikBEjsLGksFogTimmM6tUxJmCJMjz3BXyWAcLfWNKev76S0hhr4HntBOK
	 mX8Vq73pjD34HKyrIPQd1nnHXvyHhnqXr/Y2XBY8bujPLUDGTbFMDs+isKuZt8gcVj
	 aJ8er/Gsjdxw1tTR7wYjiQ8EbL7UfN2NK4NWdf5Y95Aay7FGG2HohS/XksIzdv3Ddv
	 t/E3sD1bqOqc7ZMVMJQbfGLN6CvDUfGqZKHtmvzHjf93LPE9fML5wgCb8KEaAy5WjS
	 jdbnMfNo4rUfT1jeaKk2iH5vDwWrwv3Isya7WJjq4r6uo9m9TE9UtaByMnkzNswxLe
	 Qope5ARpakCKQ==
Date: Tue, 24 Feb 2026 15:49:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
 <horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>, <v-singh1@ti.com>,
 <vadim.fedorenko@linux.dev>, <matthias.schiffer@ew.tq-group.com>,
 <vigneshr@ti.com>, <m-malladi@ti.com>, <jacob.e.keller@intel.com>,
 <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <srk@ti.com>
Subject: Re: [PATCH net 2/3] net: ethernet: ti: icssg_common: set
 irq_disabled after disabling TX IRQ
Message-ID: <20260224154953.63b558c1@kernel.org>
In-Reply-To: <57e05b57556e94ed666acd8b4c542efc28e7408b.camel@ti.com>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
	<20260220041431.372610-3-s-vadapalli@ti.com>
	<20260223184840.06069afa@kernel.org>
	<57e05b57556e94ed666acd8b4c542efc28e7408b.camel@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Feb 2026 17:54:18 +0530 Siddharth Vadapalli wrote:
> 			CPU0					=09
> 				CPU1
> 		----------------
> 								--------------
> 1.	TX HARD IRQ Handler entered				NAPI TX
> Handler is running
> 2.	irq_disabled is
> set							Sees irq_disabled being set
> 3.	Starts executing disable_irq_nosync()		Invokes
> enable_irq() for TX IRQ before its really disabled

Could you resend your last email fixing the line wrap issue? It's very
hard to read as it arrived on the list.

=46rom what I gather you're concerned about the case when hard IRQ and
NAPI run in parallel. But I don't see how that could ever happen for
Tx (there are some complexities like netpoll and busy poll but those
will return false from napi_complete_done()).
