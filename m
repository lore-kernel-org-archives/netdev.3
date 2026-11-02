Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616596;
	b=gSpSqq8HEfcVB4ydE9nt2YWyLDhK/TfmCfVeRM4t/smbbc1MEp2Yy6b0dd6TK27QJ47S
	 c1ofgKPeHNsYJKtsVe+VQfDAVb7QHSgXPJrQur6akvGAOY+ONL/CZndrroC5ZEluXJUtu
	 w0r1GDNwKUbTSTTw6f4oiH0JGwmd7idsd6xxaMPJdE/kOR8KkFt1mweZjNxsubrbtSSu0
	 GU6x2E7SViaK/AXKk7zAHRUSP8iU8LHcknL8nR2EzLrihfY9BPXp6bTUSB4Kka3ySnNvy
	 RbLDbH68e50da7LG5nu+xV4Tbym4MYl68FXvrYrvv0vbCkSamMGvA+POZTG+iv5c5ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=CVZ3o6zqvdO+UdSJuzcJgKErPDfaQVCA2C9E6e0ATEddl+CwK9+ZXwmU+amLXA7tKFCk
	 pO4iD5H/iqYGnFh9wv9dMhqjOI1B2GDcjDSN7mzkyojePurbhuOwe4ZyVanXmv+RjK614
	 GYkxwU0iR968O7CJ+uEpWluOG7q9xImZBeyTYheYcTV3ieuVCnJsHT8e5ZI1wGTo8dfnB
	 NLcG+rVVk8FhFjxacJwszbxuY1/pjCDcVwexeXQYuC+xkwvOuYdWjBFQ5s31ENI1te1LD
	 AkyomuEe3p2SOMNKAH5wnzELsBNx0EHR11PZET1k48Jo9ZkTM/XiguVK49lSLWcGeWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd1Y+lI2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5D606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd1Y+lI2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C192C1F000C1;
	Mon,  2 Nov 2026 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616596;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dd1Y+lI28WyADcO2EB9JuvZE9YqJbSNFoL0yN2T5aVatUMAaTDVZxdX4NWQ6dh7kK
	 BeGn7HEgzu5zmyGWrWNH3fHa3Pb4DMCM00PUzA8ABi3wXTjoV4uONZ5A6Dfr8pB8xj
	 dCU7ciqzR73w165bgwosHg9zMwrkmguX9dWgMqk+rf789PLiHUR/JrhSyZRT3omg3f
	 3xopf1KPTac84IknFxGCUd9oPpgj/tj7Ub8lO0V15yFxFqXBaSao7Z8kwPOhfCtk5z
	 ZibVonzUMr6wRmWMPSSd0EBIQl1IrCa/Z3WsAczfXhqbQjNQvrbQ6SunwcD10jL2bo
	 ESbAO18ggwPZQ==
From: netdev-bot+sinfo@kernel.org
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net 0/6] ice: fix DCB lock ordering
Date: Mon, 02 Nov 2026 10:49:55 +0000
Message-ID: <179361659537.3286.125563824218861188@kernel.org>
In-Reply-To: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
References: <20261102105346.30739-1-przemyslaw.kitszel@intel.com>
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
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
