Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4642253D
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042887; cv=none; b=NHtHrdgYEXbiC3LDyx1Wm9LEerinInmgs8pcPrX98oTjBTCjscoGMOLsJN3BWqGTqouCloxJuE0qm+4tzwareYrw0q12dioQL1N5yvsL6gLsJKxPoGlYEb45ZLVUUS4Q8eL19ZQaW9yDAEIyKvTyuZvba2R6XfMGEIvcsO/FDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042887; c=relaxed/simple;
	bh=CLjaWTyMhFbnQTgfJnd+8JUc3lri4LvTU5LFo09SW40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9MHVG3wAURVS0HoevvSkI4MPtzWwtpclFYKNozGn8/xed1AhyACA7oNxr83Mie/GeTIEJbY6hK29XiE+UZzn55U6ffLtNGJV0++nti3K2PP+5vyIwomLnlOJR1cpzSsMe1QD5Y4Uf7aQIhvLvTuwqG+3DJuMUYbnqwAfvBd1FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkNV8z6H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkNV8z6H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787042876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpTZTYynGJsI6iuXZniQURDVoFbgSn6sHUGA74z8Dho=;
	b=PkNV8z6H+TQp21VUdRjnQu4BPDNNTKWLcX1CoDaZdISfDx8VLLEt+5gBbVOo6MKYuxmQ+r
	Eh6uVUu94swcIpf/H42I+IHlHlyD5EeLf2yArudCRriPLIRE59y20QPClY2/7cZfsjEg09
	WExa89VMjpZKVddirEPN7atpyVBuj7k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-gmIWz28oOKS4oulf0cXzeA-1; Tue,
 18 Aug 2026 04:47:52 -0400
X-MC-Unique: gmIWz28oOKS4oulf0cXzeA-1
X-Mimecast-MFC-AGG-ID: gmIWz28oOKS4oulf0cXzeA_1787042871
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A408718001DE;
	Tue, 18 Aug 2026 08:47:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.207])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82BB2422;
	Tue, 18 Aug 2026 08:47:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: zhilinz@nebusec.ai
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net v2 1/1] ipv6: flowlabel: cap duplicate leases per socket
Date: Tue, 18 Aug 2026 10:47:41 +0200
Message-ID: <20260818084741.44873-1-pabeni@redhat.com>
In-Reply-To: <528bc30d301bcf32aca37cda1933b617d2d295f4.1786447968.git.zhilinz@nebusec.ai>
References: <528bc30d301bcf32aca37cda1933b617d2d295f4.1786447968.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
ipv6: flowlabel: cap duplicate leases per socket

This adds a duplicate-lease counter to the socket-list walk in
ipv6_flowlabel_get() and rejects a new unprivileged lease with -ENOBUFS
once the count reaches FL_MAX_PER_SOCK, before linger and expires are
refreshed.

A few questions about the new counting and the capability query below.

> diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> index 1ab5ad0dcf24..55cc5ec485c5 100644
> --- a/net/ipv6/ip6_flowlabel.c
> +++ b/net/ipv6/ip6_flowlabel.c
> @@ -617,6 +617,8 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
>  	struct ipv6_fl_socklist *sfl, *sfl1 = NULL;
>  	struct ip6_flowlabel *fl, *fl1 = NULL;
>  	struct net *net = sock_net(sk);
> +	bool cap_net_admin = false;
> +	int dup_count = 0;
>  	int err;
>  
>  	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> @@ -652,10 +654,14 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
>  					rcu_read_unlock();
>  					goto done;
>  				}
> -				fl1 = sfl->fl;
> -				if (!atomic_inc_not_zero(&fl1->users))
> -					fl1 = NULL;
> -				break;
> +				if (!fl1) {
> +					fl1 = sfl->fl;
> +					if (!atomic_inc_not_zero(&fl1->users))
> +						fl1 = NULL;
> +					cap_net_admin = capable(CAP_NET_ADMIN);

[Severity: Medium]
Is it intentional that capable(CAP_NET_ADMIN) now runs on the normal
success path of every reuse GET?

The only consumer is the later test:

	err = -ENOBUFS;
	if (dup_count >= FL_MAX_PER_SOCK && !cap_net_admin)
		goto release;

which is only reachable once dup_count has saturated at FL_MAX_PER_SOCK,
so for a GET that succeeds with dup_count between 1 and 31 the result is
never read.

capable() is the auditing variant:

kernel/capability.c:capable() -> ns_capable() ->
	ns_capable_common(ns, cap, CAP_OPT_NONE) -> security_capable()

and SELinux audits whenever CAP_OPT_NOAUDIT is not set:

security/selinux/hooks.c:cred_has_capability() {
	...
	if (!(opts & CAP_OPT_NOAUDIT)) {
		int rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
	...
}

So does an unprivileged process looping
setsockopt(IPV6_FLOWLABEL_MGR, IPV6_FL_A_GET) on a label it already holds
now emit one "denied { net_admin }" record per syscall, on a path that
previously performed no capability check at all?  capable() also sets
PF_SUPERPRIV for privileged callers that never end up using the privilege.

Since the "if (!fl1)" block is re-entered whenever atomic_inc_not_zero()
failed, can this also run more than once per syscall?

Would evaluating the capability at the rejection site, or using a
*_noaudit variant for this speculative query, give the same policy without
success-path side effects?  Note the "|| cap_net_admin" loop shortcut just
below depends on the eager evaluation, so the ordering would need reworking
rather than just moving the call.

> +				}
> +				if (++dup_count >= FL_MAX_PER_SOCK || cap_net_admin)
> +					break;

[Severity: Medium]
This isn't a bug introduced by this patch, but a question about how much
of the pre-existing growth path the new counter covers.

dup_count is only incremented inside the "sfl->fl->label ==
freq->flr_label" branch, so the new limit is per (socket, label).  The
pre-existing use of the same constant in mem_check() bounds the total
number of lease entries on the socket:

	rcu_read_lock();
	for_each_sk_fl_rcu(sk, sfl)
		count++;
	rcu_read_unlock();

	if (room <= 0 ||
	    ((count >= FL_MAX_PER_SOCK ||
	...

Is FL_MAX_PER_SOCK now expressing two different policies, and would a
separate name for the per-label limit be clearer?

Also, the reuse path reached through fl_lookup():

		if (!fl1)
			fl1 = fl_lookup(net, freq->flr_label);
		if (fl1) {
recheck:

arrives at recheck with dup_count == 0 and never consults mem_check(), so
the first lease of each distinct globally interned shareable label is still
admitted with no accounting.  Can an unprivileged caller still grow one
socket's lease list to roughly FL_MAX_PER_SOCK times the number of
shareable labels reachable in the netns, each node pinning an
ip6_flowlabel and lengthening the O(n) socket-list walks?

The residual looks bounded in practice: mem_check() refuses new-label
creation for an unprivileged socket once fl_size >= FL_MAX_PER_SOCK, and
net->ipv6.flowlabel_count is capped at unpriv_user_limit (~3072) per netns,
which works out to roughly 3 MB of ipv6_fl_socklist nodes per socket
reached via ~10^5 setsockopt calls.  Before the patch a single label could
be leased an unbounded number of times, so this is an improvement; would
accounting the whole lease list the way mem_check() does close the rest?

>  			}
>  		}
>  		rcu_read_unlock();
> @@ -679,6 +685,10 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
>  			err = -ENOMEM;
>  			if (!sfl1)
>  				goto release;
> +			/* sockopt_lock_sock() serializes the count and fl_link(). */
> +			err = -ENOBUFS;
> +			if (dup_count >= FL_MAX_PER_SOCK && !cap_net_admin)
> +				goto release;

[Severity: Low]
Could a selftest be added for this new -ENOBUFS return?  The existing
in-tree contract test cannot reach it.

tools/testing/selftests/net/ipv6_flowlabel_mgr.c:run_tests() performs only
three duplicate GETs of label 1 followed by three PUTs:

	explain("can now put exactly three references");
	expect_pass(flowlabel_put(fd, 1));

which is well below FL_MAX_PER_SOCK, and the wrapper runs it as root:

tools/testing/selftests/net/ipv6_flowlabel.sh:
	./in_netns.sh ./ipv6_flowlabel_mgr

so capable(CAP_NET_ADMIN) is true and the walk breaks after the first
match with dup_count == 1.  As it stands, the test would still pass if the
cap were removed, off by one, or rejected the first duplicate.  Exercising
it would need more than 32 duplicate GETs after dropping CAP_NET_ADMIN,
similar to what the existing IPV6_FL_S_USER case already does in a setuid
child.

>  			if (fl->linger > fl1->linger)
>  				fl1->linger = fl->linger;
>  			if ((long)(fl->expires - fl1->expires) > 0)
-- 
This is an AI-generated review.

