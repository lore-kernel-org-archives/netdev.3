Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479173;
	b=yBKjkZX+n4Xes0/LpH11QX2AfKUQ4ytSjGqOwSvE2rHpx7ALVZwBxxkSbs7769jW8Saa
	 2H/m/rPLbGf15+y9/w8qyhe+LLE/uS5ToQw/htcHiqvJF6K05ZYUgnTz/drnmo85J5SrX
	 /XJN0wgUwbgla3ZojWKZ4T87xJQLlJFnp2lH0r0HUBejZmpW30w+WP6B0x+FMievLNLUD
	 elV1ARc856y3LN808/LlEHl0F/mMFYp69Pg248VXzWhJc6IglubNZWplsniLwLzx6LdX4
	 Lr0YIGiZdyZFoxWW56YP+xDNdmw9RDW9w+QsXJidZAsyUsGavOt81FWvJpce1AQWtMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iSWGc1+jTASEcnUfet0o2SGVDT7thSeomcVfc2dZPz0=;
	b=XH2ERmA3pKbAeLEfOh1ZhRBBqFmEoreXbjPVIAn7D8l4lPyelc3MUGKMvo4LCq4msMpZ
	 GceTpIVAVsddYIQU5CkU8hoesPkvG19TQQFtK86k3/MIcIo7E21AuRZd5+SITgXjQJOjL
	 GX9+sadKz0KIus/U5HUGVmdlroBOsdbLMH9b6BM3FVcTu+Wp9nLQDb6lnWHjn1wiq59UC
	 33Upek8DIYGwFALRywjyh9ncX03UZHzNEAjumIHccT/wB/Y4Ea/zyk7bq2qSfWMtSWqrm
	 MQbCod4idnKJ4Q5WQDSsxLzSdJJyh/OlMNKT2XnjTcCN4Lv/RClIMndmO/myavkomyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1Jm8RhE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53423606A323;
	Thu, 12 Nov 2026 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1Jm8RhE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E3D1F00A06;
	Thu, 12 Nov 2026 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794479173;
	bh=iSWGc1+jTASEcnUfet0o2SGVDT7thSeomcVfc2dZPz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1Jm8RhEU0PBlL7g+ZfkSDkfpt6lj13hZIek3gTaJj2bOWATz4rJmQjeRAJC1hzpc
	 oIUTPCCLqMS6bzJfdLlieN9ISU1Gv+IUeID9DTAZVLxj5kYP1Qr0La655her9/tfdN
	 OBWfOWsLbVg/lNfhVdnDlrGjbSeGoRjgPllZwzl1VwvkysLJAMK5rq3Fyc3qiwf7bW
	 penqdwfT8EZWoSOtSJqYYV4OsNDXJIXlvo2maRRt0EynkA6yFHXTqo+0tpyAibG4qW
	 uSc4Es1zIy2kLjgcyFJnCJo/pEXnqgusGuGik0WM+5cFZ4WlXGTJS34z1EndIhl/aY
	 kNv1XCWxfsxxg==
From: netdev-bot+sinfo@kernel.org
To: Meghana Malladi <m-malladi@ti.com>
Cc: diogo.ivo@siemens.com, haokexin@gmail.com, philippe.schenker@impulsing.ch,
 devnexen@gmail.com, horms@kernel.org, jacob.e.keller@intel.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Vignesh Raghavendra <vigneshr@ti.com>,
 danishanwar@ti.com
Subject: Re: [PATCH net v3 RESEND 0/3] Fix switch mode for offload and
 non-offload cases
Date: Thu, 12 Nov 2026 10:26:11 +0000
Message-ID: <179447917161.2168702.9362989758229772511@kernel.org>
In-Reply-To: <20261112102140.2744508-1-m-malladi@ti.com>
References: <20261112102140.2744508-1-m-malladi@ti.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
