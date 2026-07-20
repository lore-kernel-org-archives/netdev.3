Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9793D88E5
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551338; cv=none; b=LtIWnLdgvbE+7nwpikT6HR6v2GfKp29pnjGB5atCzIFeY4wunCIQ+2gG97950G8lOfDpwKJxUDOfL1buzfYRkQlgKkMfg0iNdAQo61TzbimBS8fnTUANI/FbSn9IuvlOudKFrmwxJU60e8Ff7IgO7BQqaM4IlwQIPY96GD/M6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551338; c=relaxed/simple;
	bh=O0U0QH93kFMAnNCqW3cDj3rG4kKpvj/nPD7Ek6MTSfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lUWLOIk17sZEoBSOYoy6fZMp8vdl0ixDE6S9w5VQME+Ja82wSfb5Z8P9f62J3fqD75A8Zl0lD3LcoDDluKdbr92ga6pFgdTbsFZ/fxivJMo5cKg2V6mh4L2MnbcUBZBC/MHltXK43UF6JqVtHj7V0ZtTuf3MExyJ4TidPqUQ6/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aollV8ef; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aollV8ef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784551335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q3J/GEMhDjOF5ve8nn5RuxHQfZV2q9C7kXXtulPd5Qw=;
	b=aollV8efUzsp8gxLXI2OTgcEYgNhhbYZYon9EjqMygKmnuMR1nUr+Q/5Q1fooqjTJoN6Go
	4PIk6maeWqJ9JonNl84lOTI5HtR5SU3FY52c0OZ2vLNAmHpIhAGmGhMlmDZAMl2/aC1WoR
	ZRo4DuCiLYtBh94/+PD98p9qWR/yFZk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-5O6-x0SWMQm8U91YV3QLUQ-1; Mon,
 20 Jul 2026 08:42:14 -0400
X-MC-Unique: 5O6-x0SWMQm8U91YV3QLUQ-1
X-Mimecast-MFC-AGG-ID: 5O6-x0SWMQm8U91YV3QLUQ_1784551333
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F318E1800660;
	Mon, 20 Jul 2026 12:42:12 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B484195422C;
	Mon, 20 Jul 2026 12:42:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, i.maximets@ovn.org,
 echaudro@redhat.com
Subject: Re: [net-next,v4] selftests/net/openvswitch: add SCTP flow key test
In-Reply-To: <20260719162657.3263089-1-houminxi@gmail.com>
References: <20260719162657.3263089-1-houminxi@gmail.com>
Date: Mon, 20 Jul 2026 08:42:10 -0400
Message-ID: <f7to6g1q1ct.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Minxi Hou <houminxi@gmail.com> writes:

> Add test_sctp_connect_v4() to verify OVS can match on SCTP flow keys
> (sctp src/dst port).
> 
> The test sets up client and server namespaces connected through an
> OVS bridge, installs port-keyed flows, and verifies:
>   - sctp(dst=4443) matches client-to-server INIT
>   - sctp(src=4443) matches server-to-client INIT-ACK
>   - removing flows drops the connection
>   - reinstalling flows restores connectivity
> 
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---
>  .../selftests/net/openvswitch/openvswitch.sh  | 105 ++++++++++++++++++
>  .../selftests/net/openvswitch/ovs-dpctl.py    |   5 +
>  2 files changed, 110 insertions(+)
> 
> v3 -> v4: rebase onto latest net-next (2026-07-19), resolve test list
>   conflict from merged trunc test

Hi Minxi,

Just a note that this will conflict with the current in-flight patch::

   [+]   1. #14675655 [new             ] [net-next,v5]
       selftests/net/openvswitch: add ICMPv6 echo type match test
   
It would be best to wait before reposting, or to bundle all of your test
case updates in a single series.

Given the other patch is already reviewed by me, let's wait until that
is accepted upstream before reposting this.  I know Ilya had some
comments about it previously, but haven't checked to see if you've
addressed all of them.  And a nit:

[...]

> +# sctp_connect_v4 test
> +# - sctp(dst=4443) matches client-to-server INIT
> +# - sctp(src=4443) matches server-to-client INIT-ACK
> +# - remove flows and verify connection fails, reinstall and recover
> +test_sctp_connect_v4() {
> +	local t="test_sctp_connect_v4"
> +
> +	which nc >/dev/null 2>&1 || return $ksft_skip
> +	nc --sctp -z 127.0.0.1 1 </dev/null 2>/dev/null || return $ksft_skip

This can probably be instead::

  nc --help 2>&1 | grep -q -- --sctp || return $ksft_skip

This reads nicer to detect SCTP support in 'nc' binary.

