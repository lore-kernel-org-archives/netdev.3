Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01624285072
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971349; cv=none; b=T4gUn7l6YxWxDukkUgarO9h4QXtSura03ZX7ylnRfCmVw7/ajROn2/6BujZX/1WUsbJkBOs7h7isHY/ivg8010CVcuZW1ri0yLXicR5wEwZXpk3SRWCXMY8PlYxVQhiUc+p3Pu7vo40o+uVANTtP+VxTye0gLvSsacyKbwZXze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971349; c=relaxed/simple;
	bh=8mrA+bQiXpYaBTGHL7k3MZUvo6xYXvYgLgakzL63cPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0nsxuRRqQdWZrAJNkQpyhUhxkvQM3OrMVZVK8F1PC2Y0xTfmwwg72yKLR9mmQ6/uQpjNIk7I66RDzsZwlMJdrzGL3LCQYuEG+tqfdCxC6fv9dV7Ft1tk4N9c6KGC8F4nUREwgzkdra+8nW25htFOhbs0zl2OLCK7ikTZ0bW6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtkpyO97; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtkpyO97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB2E1F00893;
	Tue,  9 Jun 2026 02:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971348;
	bh=8mrA+bQiXpYaBTGHL7k3MZUvo6xYXvYgLgakzL63cPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BtkpyO97lepeavCkG0m5/cyRh/NK4XSjOLsdE4uUNHHlkEYX76G86KdyhQ7h4Y044
	 wBQPJyzmKNYVotOphdGUkbhjE+GKQGmWI8GNsZEXMy+ocQePv/BefMEqrXnouioHAT
	 UIOaBBn72GtkIbK7ET5KbW3VsztTUuJV4K2Htp50VQbZWRfxOxoUD8u18EsHE80HVn
	 Tb4ih5OZ6fHznywGMULRNNOXbtjC1oma/+KDii7KA7rSVJhZXkd4uMVHVM47DbRPUR
	 tdvJFC3k1fmQkffDNzLc9FcE5V+Ie8/dkFIu4whjHTQRmCgBH6HUqpX/nqSz3TzIz5
	 JJnHh84fQMz2A==
Date: Mon, 8 Jun 2026 19:15:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next] net: airoha: Add TCP LRO support
Message-ID: <20260608191547.21a29bb8@kernel.org>
In-Reply-To: <20260606-airoha-eth-lro-v1-1-0ebceb0eafc3@kernel.org>
References: <20260606-airoha-eth-lro-v1-1-0ebceb0eafc3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 06 Jun 2026 16:45:28 +0200 Lorenzo Bianconi wrote:
> Add hardware TCP Large Receive Offload (LRO) support to the airoha_eth
> driver, leveraging the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues
> mapped to RX queues 24=E2=80=9331. LRO hw offloading does not support
> Scatter-Gather (SG) so it is required to increase the page_pool allocation
> order to 2 for RX queues 24=E2=80=9331 (LRO queues).

NIPA says this doesn't apply
--=20
pw-bot: cr
