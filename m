Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893030;
	b=O6qkdNLFhfXLJT1uMHtHLmiU3vT8rWAP2VY+KhQVRMU/xiI04Qj82oWiXvpSXfsC8oEa
	 /2Q4MP/sZPChywtlVQYJkWkGm+gyRFyLUQCEFBUKA02ZmuXI1NwwSsGfd8hnRur7QctXg
	 dXfdyduR0rWu+hHoVn0j+jRjztdv74E9GLWZVig8BQ7KSN5nDLaSqbFxAmMHSXq0BNVly
	 SZqDOh1QxHZhbLffofaReZXtuBX6lEiJKnO0l8MX3/qoEYlfDuwCiaTRLq1i4O2wnjizp
	 d4ALzh4ufiE7Yeso/5EPP/RCI6q5wiLvRvBLft6JoDatIhQR1A7gZlfm+DkTcY22isA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kvailjwqfOmhbJJjcy8TbvowePxzON+06QO6Up9gGT0=;
	b=eXVSELDQ74L+V8hnzI3wO2wFoiqN35GxrGkT2CaFpxA9gejNtCQJPmxDy5HeUNJ7PqwV
	 B1DakrCC+iOuOr3VZVUlgdwFJLfLklxmFQ3NToCurr7iVfmRIde/+crfwnP9vymAjn2mm
	 5amNRQmaRWKjRBLFdNr9K0ZDQIka2OFRKK+Ws0ukOS7jIb6kUudI7duxeQSdU5zngoVWi
	 kW3CJdR/+HL47twEY4ZmjrHkT/rHNZb0efb/vAC/okpzxnSTa6/eK5s12ORx0qCtjqxc2
	 J+vhBsfsrYXco7ocIKYHGe5Hy6PQ1J5+OOT3pYGEXRAm7Wws5vgaiZoGavO/5cazkmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46704606A32C
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 15:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46704606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c40bbd26f74so214856166b.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 07:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793893024; x=1794497824; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kvailjwqfOmhbJJjcy8TbvowePxzON+06QO6Up9gGT0=;
        b=Gxle+Ke/ft0qPJDBX0JQWzA1ZLmQgVZzBrWyEVoNZxTcMrrajfo1O4ASCBG23EIcjq
         cUy28QM3QPVKkqYviAKt4UuDyzpJABmNQR4JRuUY/9J9Hkfes1ObSbTFJBTMv0xgyn36
         I605vsADiFHcxXf4eX61I0j4Gi+kKyS6oNG5NvaDGMqTtAbtArrAfHjtJRgz0KAQXT73
         KzZfmQgJwuEWSDCZ0Dz1NtIeuRDvR+OePZg4x0U3S37xPzoaWN3MauXtR0KYCrK+pAhq
         rsIk4Yf8fmIvbb2p7AhpUlOpetxQvv3G4Qgr9XZcKOy2pWy+dVo2136CYJcH164SwW/n
         pIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893024; x=1794497824;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvailjwqfOmhbJJjcy8TbvowePxzON+06QO6Up9gGT0=;
        b=iu0vi4X3/s7W2E0+tyZCG398kBpwZ92pPUMYIJ9/sp5BaGPdS5fd4TCUZRS2D0AVdw
         Ovd0fAuUXF8CSqrKpd9onRVhz+PtmTMG/+msxNplJ6NzHPgGs8trA3Y30FFCVDRxqJRn
         6ZHH9JFpr5g7pKsIc9PeTEy/nbAoxiLhd/bLlFTqouR7K2NsmGTIJ4SETP0bCym3HdO4
         Hlb8OMFGkyGOLs858EMzFIiWKxKl1kOjOINyWe9i5IBBodi/2Y072jY1e49RYRjIbTXD
         kZ35tw11H+resDLv+6hgkL1IaSBwStTO1lt5RZyQHyRzFN3C1JLP+8/W+7iY64ilao7n
         evoA==
X-Forwarded-Encrypted: i=1; AKwUvBw/8+IXpJa87BwwrDNtJw4cxnSg0Wc7WvTN+sWirBIIAl+AU+jCqvsaiyGMdpFOlYJLU9JFKRk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AWD67aDG5l9E1zasdyLO/BvX7l5PH7T4paIYHitII/bDPLT9J
	QlhOdiVA14Shcx5FlHV6LQlpRYUxucsbn1FWWYJRGb92yBDlFU2137jDusPbolgGCwQ2npGBTA=
	=
X-Received: from ejcwz8-n2.prod.google.com ([2002:a17:907:b048:20b0:c4d:23d9:b0d9])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:cb88:b0:c26:19e3:e98d
 with SMTP id a640c23a62f3a-c4ca7af17a5mr1750569566b.45.1793893023363; Thu, 05
 Nov 2026 07:37:03 -0800 (PST)
Date: Thu, 5 Nov 2026 15:37:02 +0000
In-Reply-To: <aunVmg42/S2uUDWR@hallyn.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <aunVmg42/S2uUDWR@hallyn.com>
Message-ID: <auyink594bxptAPN@google.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Jonathan Calmels <jcalmels@3xx0.net>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-api@vger.kernel.org, containers@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Nov 03, 2026 at 06:37:46AM -0600, Serge E. Hallyn wrote:
> Generally, if I, or some users I support, need to use unprivileged containers
> or user namespaces, then when an 0day comes along, I can hopefully trust them
> not to exploit it.  The biggest danger comes from the fact that, right now, if
> they can use them, anyone can.  So if someone can trigger some other code running
> as user nginx or something, that can become a root vector.
> 
> So what if we had a built-in feature or LSM which implemented a credential based
> whitelist, entered at firstboot?  Something like
> 
> ```
> # Default deny
> uid == 1000  # approved
> 1005 < uid < 1010  # approved
> gid == 1005
> security_label = lxc_user_t  # Not sure how far we want to go with this
> tty # must have a session
> ```
> 
> Now, if you want to use user namespaces for generic sandboxes for all
> users, e.g. to confine browser activity or nginx modules, then this model
> may not fit.  Or rather, it might need a few tweaks.

Thanks for taking a look and sharing the credential-based allowlist.

The latter scenario (generic sandboxes for all users) is actually the
primary use case that I'm targeting. I want to allow unprivileged users to
create user namespaces, e.g. for sandboxing, but without granting them
security-sensitive network capabilities (CAP_NET_ADMIN/CAP_NET_RAW) when
they are not strictly needed, given the historically high risk of local
privilege escalation associated with them.

The two approaches target complementary layers of the problem. A credential
allowlist at creation time controls who can create a user namespace, while
this patch series controls what capabilities are available inside that
namespace (and its descendants) once it is created.

Gating creation works well when there is a clear boundary between trusted
and untrusted users. However, in a multi-tenant environment (like a large
container fleet), we generally treat workloads as untrusted by default.
Because we still want to allow these untrusted workloads to use unprivileged
user namespaces for sandboxing, it is essential to keep the attack surface
small and follow the principle of least privilege whenever possible.

More specifically, this patch series enables that model of safe sandboxing
across three key use cases:

1. Configurable capability stripping: Administrators can enable unprivileged
   user namespaces for all users to support sandboxing, but configure the
   system to strip CAP_NET_ADMIN and CAP_NET_RAW by default in new user
   namespaces created by unprivileged users. Basic sandboxing rarely needs
   these (except to bring up loopback, which Patch 1 addresses via
   CLONE_NEWNET_LOOPBACK).

   The per-namespace bounding set can enforce this either globally via the
   sysctl, or explicitly via clone3() at the container manager level. This
   restriction is monotonic and persists down the namespace hierarchy.

2. Selectively granting CAP_NET_ADMIN: Some containerized workloads
   legitimately need CAP_NET_ADMIN to configure advanced networking for
   sub-containers. Because an unprivileged creator's child namespace is
   bounded by:

     parent_bset & (sysctl_ceiling | creator_effective)

   a container that is explicitly granted CAP_NET_ADMIN in its own user
   namespace automatically propagates that capability into the bounding
   set of any child namespace it creates (unless it is explicitly
   dropped).

3. Dropping capabilities for nested namespaces: If a container with
   CAP_NET_ADMIN needs to spawn an inner user namespace to run untrusted
   code in a nested sandbox, it can use CLONE_NEWUSER_BSET to voluntarily
   drop CAP_NET_ADMIN from the inner namespace's bounding set. This
   guarantees the nested sandbox cannot access the capability and the
   restriction persists for all further descendants.

As a quick clarification on how this interacts with the hierarchy: the
bounding set restricts tasks inside the namespace and parent tasks
relying purely on the parent-ownership check. It does not restrict
tasks in an ancestor userns that inherently hold the capability.
Therefore, in the nested sandbox scenario above (#3), the parent
container with CAP_NET_ADMIN can still configure the sandbox's network
from the outside (by using setns() to enter the nested netns directly)
even though CAP_NET_ADMIN is stripped inside the sandbox userns.

