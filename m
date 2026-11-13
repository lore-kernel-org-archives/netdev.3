Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531177;
	b=USbkYdI3qc0GHlIngP/4QmmabpFUPmbPpZ/fqegQSlwIdEmo1nf3NdnO788cBK4hkldB
	 /MaOPsDgd54PCmAEYdMkrZcwUxtiiMNIVj0BPaBrnM6MIkSVhIinN8g1rJKnF9ui1XbIk
	 ZdDXtMojmrr6qI5K9meOQ+s7qcrbXMAAI+OBeL1/x+urayfYCbHudln6CzqTe2iuy9Dyk
	 EOUWlisTsf0kYBrGiJVzJTTxf+vdVCQsdsPgVjv+XbruOBnDEfVMa6EGm07vy6+XbTaka
	 8IihCPl4mJ6MuXpDozjC4muN8BD+1tiu1qIJsJuD/ImeSuDY+qjkgowXXv225F+F/Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531177;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	b=uu6T9fa5PrbliRo0uuSyfZmDBc50GptMZU9SJutLDV0fp75xbCoijOBd0JACPRVp6TWg
	 0PlM8N3Jj+AMrwSboRPTG5XYmrFVO+oM+cEjwAR19Nljl7IwwxI48G3OdYb78Mdkig/2d
	 YDBoeOc0VF4/RWgGqgfwjLhmtl1T1fierAaVZYDsgxwld10DodIBEIZ1JseeM4HUfm+xA
	 lugi8qc6OJ9a3HYEGUxVi0NbQXQA9gwxpXidpdiU0Fkti/IOcD3yNu3M7hPbhix24Cl/2
	 I7ufIwJv9o+AzSe7OCetiv7EslSZbwqzn4r2gR/Rt5g3N3jQMVxhVprf8d86Nkcv1pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSSSLfHG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906E606A333
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CSSSLfHG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460031F000C4;
	Fri, 13 Nov 2026 00:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531176;
	bh=QRKjoaIFdZcdNI6xhQFS3ddkteDcVtqc9gdnFl/fkT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CSSSLfHGaPK8/bewAq4vTKA/832sxH6yw1wVvTc0Mdc2FfxKU94qlHmA87PkqZI+u
	 kIbI4mcJMqCpV2hTG/s0f4cQk7lkAjKIsZVcHGnjPFiP8Njrioah4QiFsoeX2nCkUW
	 wvW9j6ArPL3i76U+Gxqf81KDg3zx1IjJhRqCxRmZn8TIIdoy2AMDqpN+IBLt2kRY8N
	 vIxsW6rfyNodxS3Jo/B/tL+snU5jrnmnRQVywQfBE+onUnPLfzmtiNyzBETWTahkX5
	 YlHJrd/Prv0jC86aZ+zqjHOBEtoNG83653NFc4xn2fpm9PZaGTsDL4YewT5gkVSxvq
	 K3a5JaoEPwD1A==
From: netdev-bot+sinfo@kernel.org
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 mheib@redhat.com, fballuch@redhat.com, aleksandr.loktionov@intel.com,
 luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-11-12 (i40e, iavf)
Date: Fri, 13 Nov 2026 00:52:55 +0000
Message-ID: <179453117578.2168702.15494709019448210749@kernel.org>
In-Reply-To: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
References: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

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
