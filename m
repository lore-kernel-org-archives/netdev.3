Received: from sender-op-o18.zoho.eu (sender-op-o18.zoho.eu [136.143.169.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DE4F7971;
	Tue, 14 Jul 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048649; cv=pass; b=YNqUY8ap25owAKcp9IkpcZwqyuKXaL0h4aN59CnQX7wy09DzpRK01WiSpJ6+PupqULSj9F6c1DoN5hkFiD1bkgXpQXnZ1QMdRIip4a16cY3MtX3VgaavJx6mcQootAuxdeuLvWighPdtKC15s98DIffkF+36zvE4PuQtJfig54A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048649; c=relaxed/simple;
	bh=resfdQh69IM8bJg/V0gw81nyo3dOmsoEtawdraIuE8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVhZmPw8gcopniaFWDT5cjlaI8K6XmYfxIeVEvAz8FUjwGUp/lYUdApZl3qGBUDwxj3/CsMRS1JT5EHaflNsCUq+FT2CtXmb9dxwrTEPBYo+aRfC1hC1yRhvxiULbEL5LzR9mwcbVwRzI1IE3bBLpdVyJiegLqW03ACAB4k1jSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=qe74OPfY; arc=pass smtp.client-ip=136.143.169.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="qe74OPfY"
ARC-Seal: i=1; a=rsa-sha256; t=1784048605; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=aOMShas0CdF/GZkGptehoUuCP4YMvOlYRxkWKRMMhP/utXQpAW/yV67421t9Lo02CGlajHCF0QcOmyw47CIlxdYcjhb3hsmB+RDEeU+Xi1iFmAC7GQYsdEs0Ag5phHsmn9RUQPtW+SRtnR8RTaARYkO9jieHps0OdOvv8N+2RA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784048605; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=resfdQh69IM8bJg/V0gw81nyo3dOmsoEtawdraIuE8Y=; 
	b=fGpQbxBYfGnfv8vSjIqUcCktmAaKJ3h5SDRUrVSBGaWrpf3oBH9YP5GdmRhr1gzZEbXP7iCsN1Ri7o7IrbJVHcM+hRBUNox6+1NKC10z+3mDUB0wi/REDkrgZJFgqZ7/S4f8cVkpT4Et3DVTflptTyVYB+L9rsyVRf7TNLwGie4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784048605;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=resfdQh69IM8bJg/V0gw81nyo3dOmsoEtawdraIuE8Y=;
	b=qe74OPfYsqnUa/spAEqJSgXmwPKO0jX1WwlFevJB1O5log4eM/GXV6oSbBAfhh3G
	ok1mjKaLbLOEfr+MUr6gNr9bCVMqVLeeY2d8d7t+ox/kMGQKjUyJH6K8pPhwvUV+yc2
	EO7qXQfZk7hJ1MYFsPT5dd9q0IRh9zkW7tLc5vgs=
Received: by mx.zoho.eu with SMTPS id 1784048601829742.5522273632758;
	Tue, 14 Jul 2026 19:03:21 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: tung.quang.nguyen@est.tech,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: cap number of nodes per net namespace
Date: Tue, 14 Jul 2026 19:03:06 +0200
Message-ID: <20260714170306.71517-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <GV1P189MB19881AB5829FF8B0B00EF158C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <GV1P189MB19881AB5829FF8B0B00EF158C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

> I do not see any issue with current code that requires this patch.

tipc_node_create() allocates a struct tipc_node (plus a broadcast rcv
link, a unicast link and a keepalive timer) for every (addr, node_id)
it hasn't seen before, and both come straight off the discovery frame
(msg_prevnode / msg_node_id). There's no cap and no rate limit on that
path, and a link-less spoofed node isn't reclaimed until
NODE_CLEANUP_AFTER (300s). So an unauthenticated peer on an enabled
bearer can pin memory just by handing out fresh identities.

I measured it: 2000 discovery frames each with a distinct (addr,node_id)
-> 2000 live nodes (Slab +~15MB); the same 2000 frames sharing one
identity -> 1 node. The only variable is uniqueness, so it's the missing
cap and not frame volume.

Still the case on net HEAD: tipc_net.num_nodes is declared but never
read or written anywhere in net/tipc/, and the create path has no bounds
check. The patch just wires up that dead counter, the same way
neigh_alloc() checks gc_thresh3 before adding a struct neighbour for
unauthenticated on-link input.

> Can you provide your C reproducer and the stack trace you observed
> (on latest net-tree) ?

There's no stack trace - this is resource exhaustion, not corruption.
The alloc is GFP_ATOMIC and NULL-checked, so it just grows memory; KASAN
doesn't fire and there's nothing to paste. I should have written that in
the changelog instead of "KASAN build", which was misleading - sorry.

The reproducer is python (genetlink + raw AF_PACKET injection of a
captured DSC_REQ over a veth pair, no userspace tipc needed), not C.
Happy to send it or port it to C if that's useful. It ran on a v6.19
stand rather than net; since node.c is unchanged there bar the
kzalloc_obj rename I don't expect a difference, but I can re-run on
net-next. One honest caveat: the single-VM harness is softirq-drain
limited (a 10000-frame flood only reached ~3042 nodes before the cap),
so "unbounded at line rate" is extrapolation from the 2000-vs-1 result,
not something I clocked at line rate.

That said, the bearer is a trusted-cluster segment by design. If your
position is that on-bearer discovery peers are inside the trust
boundary, that's fair enough and I'm happy to drop this. I only sent it
because neigh bounds the equivalent ARP/ND case, so it seemed worth
doing the same here.

Thanks,
Ibrahim
