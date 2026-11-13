Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579818;
	b=ILnCo+sYtqqOK9EcHCbm5F/Ns2sedwOJb3onksgFeRWpcPchlRZ7FVBajrQJfkWj4oAK
	 Zkk2nWdF2E2Q3Cfj9LbY58t0IW5WnwP/Sj+/30ijWDtTJxonwsyGzl5+lXfg4BXBqvwLu
	 PFYhgMjm5kuvRJujaInMZ390D7zQorGCvkZ5WRcYiOXW76BcwV7apFgfayqD/DlI1NK2x
	 5SJte3TJlmIJieosw8eXsFFhov+j5OAy44oVaGBfLyiPhddY9wwoe0MRGnlWnUiL6nvcW
	 gpzcb3NMucC9DihdXbwOum6Dn7JIlvho1i90s9mgQeB0NMa/1jQnUvOlJMQtMv3gyYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579818;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=Rma9MPX4RsgwwcQwxht51YYrX/ZjYn3nmkCrbNFZT6E7HV010B86v7zmBGqR5qd6hvyR
	 hzmA7AglTFSSyjgqFVU4LspF7ukvEDjN+kccr+tnKjyx018fXStvTYiw/yL14TQiZRrjI
	 uMIJjpq/O5XMwOu62JT5kg/KriGI5Ou7XXEWAFjfzJIRhIjhII5VQkudAcjbp+euW2Fg/
	 HXA/93oCg4yMz/Brh+1fermLq+ecjKLyD3i/s23uA9YD5iPyK/a0QIn9JkFu9g/rP0ECO
	 9vTVBCAPcu+k9sOuBuSw548YCL4Ri0a3BJBOEke9PWsuvNGK40/GNmV7i+s0peK9sgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gszlNEhi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68632606A323;
	Fri, 13 Nov 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gszlNEhi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABCC1F000C7;
	Fri, 13 Nov 2026 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794579818;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gszlNEhiMt2NPwzkdU1jTofTIZ9uH6MUZbI1QzUo3aECX40MMJdZWnqUbBj6nI4Qk
	 J/9wPSdAXaIfdzzEP6KSWs+6JB8DPirIFHiCTbnG9855UEVQ42PO/YYYcWLXe0OmT/
	 VfmEaVzZUjaNiVY7ireIXPM0au0K7aYwBw7tOq/h4b/ceKwXLIIGfR03csxqTHoF8K
	 +l2n2nMT799fM6deSaNkKDe9o1nV0vQ1f5p87gEHAf9/xSMfokjsKpZKaP3ND7BsvB
	 O+3rwfCUJdYTgWU4zXsSHymjbbaNmTJ2GiDmv4XhebnKVX9Uy1e27x1Lz/EecCvprj
	 YlYJDb1axqttw==
From: netdev-bot+sinfo@kernel.org
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] iavf: Fix potential QoS capabilities leak on removal
Date: Fri, 13 Nov 2026 14:23:36 +0000
Message-ID: <179457981690.2168702.12614327056128514312@kernel.org>
In-Reply-To: <20261113-4e14e563a1-net-iavf@mail.sdu.edu.cn>
References: <20261113-4e14e563a1-net-iavf@mail.sdu.edu.cn>
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
