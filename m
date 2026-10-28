Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146248;
	b=KejTjz/FJkcW78uYhChqDVVoDQDnHL1xzvkGs/pvGx+2IMnhtPKOtbABJXSNrJpKmk3h
	 MWnQIPEFLQgcavKP17t35amDce1QKnsp+zjjhKE97iXnGw2MpLhvjjWYPuEjCOepCxmpl
	 udy/hkmXXRaE8rxDPp1T1D98dDBvZF9vM2oKRFW+yP8nWm+EJTN3Zwc+3asHCTGFZ7TTV
	 ZyvlIn2nj7gi1Rj1d/u0SDUaNW1ewGyrhEs9bH/ZgHJIGdDqn74rzILvHMFUIl5j2sbLf
	 7rk1YHykv2Szt+rBY0KrrCasceA9oLhjunZAj1udRZAUG9jfHApPLA2WO8KbJgCevPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146248;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=T0ADKuoScLXplkv7V5CFpdVbFND9W2MYN5ZC+aXoZpsCOycbw4xySiFVBvYLw1rpUEXl
	 FCGhji0/Eqs0e5HolNGO/SYngeQqK2V3GiMRoUZ1X8nHg0sIsFSgKFMjl6IFoczISXfbb
	 WLCyKgD28qGuJiw1/p9DMMFbJIlCN3H7JRoQKFILM22r80a2UDuXsjAksvsKjsTvFn29V
	 EwZYQW+lQBuPwvo+8O+wPPI4Ut8+bJADzPfOZPiHvMXYHTd6zcp30Pvxu6xab4BmcvZrj
	 Yaa1+wBDg+zChJhie2zu/3vKMbYuhamSEy/MqQ9Wc33fLqhqNFT8NFyxRhnjQFvpKMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YA7vm2M/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B16D606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YA7vm2M/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0341F01825;
	Wed, 28 Oct 2026 00:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146248;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YA7vm2M/0dXfJRfeuIiAAIb8Icrni5dOXw7HNnIa0duBAGeq8DoUYPL8aTzITR9o0
	 qiR/LKf39MakOy7u5J+3qq/ojlVKkd034uDi7+OG4/1pgucrg3hKers0C3phc63rVx
	 Rx+BWlJG3hkgiNZitn+o7b1OTs9t9IPl0qZJYPG3XUdqb2gn/iJy5Y5DDelBNTu38N
	 enzgrs48V6mhssv5GRGBEm1gwGC/PiRQTu+gcH1ydSyhK0Q0cRiW4plT4EtygPBxxN
	 f1WV7CyGuferqTb/5Z2redb+NuiwoAvoIW6Zoi5wmd+3OOS0MCbBlL9vtzlw9eOpAZ
	 XwdyFSoau9IcQ==
From: netdev-bot+sinfo@kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org, Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexander Nowlin <alexander.nowlin@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Subject: 
 Re: [PATCH net 0/6] ice: E82x: reduced timestamp processing logic fixes
Date: Wed, 28 Oct 2026 00:10:46 +0000
Message-ID: <179314624669.3327.2992098424340476462@kernel.org>
In-Reply-To: <20261027-reduction-v1-0-81237c67a361@intel.com>
References: <20261027-reduction-v1-0-81237c67a361@intel.com>
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
