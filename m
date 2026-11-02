Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631224;
	b=0IQsVlQZqngVrTJ5Oa3lH3FrWXr/B2N/AyXkNx8K0KOViGQt5zlnoQ9PSrE3xSHd8cSA
	 LeD1cAias4P9Udkb5WIsq1MJ7L9YPmYvDtpWOAJwy1KpOzPn0tHI+x5auhZYBjzk6TZU6
	 3T+Y3Yhxn6qEzQWnKi6HwUMolzSbozQnrTykNqIm7p/gFa/OBbPM0oFQRnGzxM9nK71qa
	 JmX8gXrfbA0024MMVdNlW+1RX69ArrmteXkgBh4qVStTeNgWpa30siPaN8VyXIGAg31pV
	 hM6kvB/sAsYeAGpi1OnTzgkpvyby4P+TDJfyH9o26O/pfhz2t3C8RMzufW6tkuJjmqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631224;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gOM9EUXhqgY2H2hXo3Z4tmrYn7xzf5fZvl1TI4WQu+E=;
	b=V0eVEMtTXIVmrdEnz4kpHdaPZWilMwDT+lkbBBfdTeHEDmdm+MFWHiGc96w0tb/VstMQ
	 FlsOZEFKw32XF2SO36h5UL9fiYSRAHx6KQLmj0V+Kpjx+Q1RRJHMNdwANQlLRCMqWVKDH
	 IsFCn3vRsJErrGGTrzTC7nhrQSritoavnvi4Vyqy3v1ZN/DWqaQ58je1/YBzXN87ZTEXB
	 5iZLLQxr9Qyv13VVGUYM3tFh/hTcKJOp/l1JYvFF/7Yhq+TrK74i0Qgo08YKI52sB4b4g
	 fRPMmnXis5ZTDU2CCI0f05lZyMlHsf2XOSNYJIZFUwkGEPVcPR2LidWaO343ThPCNbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xG8M1irW;
	arc=none smtp.remote-ip=203.205.221.173
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB16093F67
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FAB16093F67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xG8M1irW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793631219; bh=gOM9EUXhqgY2H2hXo3Z4tmrYn7xzf5fZvl1TI4WQu+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xG8M1irWG35cc83KA7YSVbMBdZPjSdtCNTrNGXHWAqjdjjXjQoJZNhk74PxUJM4dQ
	 vx9xKfG3bwTZ8vpZCTa1HftayTH+/MSo7Vlz6eheHZJHNf2qUK1oN9T+XFPG4bk+C3
	 stIjzUPX2h6NcvMkeXW/QfSQlffE++sXmJ4Odl0Q=
Received: from CRASHEDROM.localdomain ([117.147.101.47])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id D6589470; Mon, 02 Nov 2026 22:53:37 +0800
X-QQ-mid: xmsmtpt1793631217tqbxmgm1h
Message-ID: <tencent_981C3D69678F830305AA7F74E3DE50C6EF0A@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5yDu9S8tfdexIZVVULNV1R/Ba0RTifKLBcLObehwVXl8N37VsIi
	 t7sEq7nx3DEoplESZ4b+CyxGb4A/AwWqGuBrgbiLhVgoVoafslQ1UogZbHT3DnsC7/ZuiaeZMz+p
	 ofeNU4f+pr9qpYbXWtkF3YwV0kLYHA4tQHjn3vq66U8+3e0U8bPUhaf5Kz8CbY7E772nTbCWesaM
	 C5vCI19/yFXb8czOOM9XBVqtwlL5JhdaiARr6wRLakaS0Vm4TrYar5j28fT6iYFi4WY3VfymeqkU
	 8213bKAf2/ZLs+uf7If1+nCwW8oPEABEzlDyIs9NIFUJ9zNQ9MxVFhMlPJZiW40xNKvx23o6Ridv
	 7jyWyOFs44hAfDEvBgbx9KRSCoN+jqTV635NZEASx1g0G6u3kLLFtNLzPRyc3WKtGQ8ZD7yxiynL
	 Jm02262KPCcP1zsEbfifwxdYk75Ix2JlWF5Y4Lfq7LHApOEgmLuJIH90qpob4BooFXRzlOKXAnUa
	 ij2+7YC9pgvnkZuR/7jwFzMBlj7VGUOImXsic79znGI9B6PpOctpufBwSreii+BZ4lxcfEkm1lu2
	 WHzDfYUDcMBEEMwjnMcJ7+4UxKdFxIIa5Oq1tNIF6E37TsNdYxLJb9Xn1Uivem5ez5a9JUirCNu9
	 qaPyMm/qLif2A9JWrMMLEf3dKeUuMW3UtRXmqrC4vlAPptdmY1dVuTHXdt30s+fENo7siN44dJbN
	 kCM6wd87cgh/9gb6pr/KRaucsDWpZgJTg2YZOseAwmYuRr/zlYekIDwMhEw63YDfBxYYMkOzzAYQ
	 2db4EI6c1ccmPWq2ATuXRV7jsZdERt3Ze4yKIOofNIdv/SFSCstdsWoF/dKU+nkZGmdspd1thOwW
	 Ak7uS8KxZvQEzYUAMXrFpyhihGoNaRcj+W+tS6aCRQ0G2UxUYwIfqY9V2p2I736aW4euJxfdeQn2
	 oTfjH9X/+1dkyRya1rmd/c7JR8wE+UasHmcAaNax45kt7Lw4CsJ9YM+ZVJR5p6na4tRBGRUoGVQ0
	 3RaL8OifyCKVFKJ//JQXqwpEFFj2QV/uh3Dix9foZv80zJIR1nD0G6rNZMyXU5kgUvPnBCqatzGX
	 AcqCIm
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Chengyu Liu <19290937@qq.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	horms@kernel.org,
	khc@pm.waw.pl,
	Chengyu Liu <19290937@qq.com>
Subject: Re: [PATCH net-next v2 1/2] hdlc_cisco: shut down the keepalive timer on ->detach
Date: Mon,  2 Nov 2026 22:49:37 +0800
X-OQ-MSGID: <20261102144937.1439401-1-19290937@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <81db96e6-f6f9-4bc5-abc7-06c76921b4fa@redhat.com>
References: <81db96e6-f6f9-4bc5-abc7-06c76921b4fa@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for the trouble. My SMTP relay (qq.com) rewrites Message-IDs, so
the patches' In-Reply-To pointed at IDs that no longer exist. I'll move
to a provider that preserves them, and if CI doesn't pick up v2 I'll
repost as v3 in a fresh thread.

