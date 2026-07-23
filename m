Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525601F3BA4
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772763; cv=none; b=ictz2tZLTchgu2+FQmI/8l/QtboxRcsH3rpgTuTeMKV6pT6AkVWPGZ2kfrLOsi5jZmXWxnxo0uuGFsPun2GhsX90wC1Telxu9EyFnB0B8fv0KzKzLkqRdtBeWALMA4k1KemuUEU0bKElg2HvNGTkKvJ3ZIcz3c+TdZAQWK6HmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772763; c=relaxed/simple;
	bh=6RD5QV0ZyGDsCbjjxojg9DmVg9ScnIWENT8ewi6VM6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ouCMGfKvza4vh3GFecl6H2vksK/eksgGAscuWXVxiD9VebJHqD3vXg3jA+wZcYAQMOyCkmwiPHuqyTjKOc2qCMAq7Ypj//MvyMfZ0h2lPzey1V07rf+EOUd0CQPI1TEkGlZwytJKpmmq19JU1KWfXY/SGOChhpa8Yw3MrwN4cTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3k1Vlf7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3k1Vlf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784772761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2Exbx18psvpECHHaE+xprlK5BZbn3LadFb5/XmWflU=;
	b=M3k1Vlf7P4TrmC0UoNfFjbcomApVmNgHlmsIiVhmyk5pJipjJaNGyhaQUritCNmiEih6bi
	7aKGea+Dfh8bD1xpaOVwilePysZqeU94exI2MSvbp6qZfBEOvcFFDBqS7PmnjBrNtYrU4B
	TEIeXVDfAn/pW6jaNLLD0HA4lng20vI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-HqxeavqANvGXsyEsnXHC_g-1; Wed,
 22 Jul 2026 22:12:39 -0400
X-MC-Unique: HqxeavqANvGXsyEsnXHC_g-1
X-Mimecast-MFC-AGG-ID: HqxeavqANvGXsyEsnXHC_g_1784772758
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 493D61800661;
	Thu, 23 Jul 2026 02:12:38 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02ACF1800258;
	Thu, 23 Jul 2026 02:12:36 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: houminxi@gmail.com,  netdev@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  pabeni@redhat.com,  i.maximets@ovn.org,
  echaudro@redhat.com
Subject: Re: [net-next,v4] selftests/net/openvswitch: add SCTP flow key test
In-Reply-To: <20260722125528.0f192cca@kernel.org> (Jakub Kicinski's message of
	"Wed, 22 Jul 2026 12:55:28 -0700")
References: <20260719162657.3263089-1-houminxi@gmail.com>
	<f7to6g1q1ct.fsf@redhat.com> <20260722125528.0f192cca@kernel.org>
Date: Wed, 22 Jul 2026 22:12:35 -0400
Message-ID: <f7tzezio3n0.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 20 Jul 2026 08:42:10 -0400 Aaron Conole wrote:
>> > +# sctp_connect_v4 test
>> > +# - sctp(dst=4443) matches client-to-server INIT
>> > +# - sctp(src=4443) matches server-to-client INIT-ACK
>> > +# - remove flows and verify connection fails, reinstall and recover
>> > +test_sctp_connect_v4() {
>> > +	local t="test_sctp_connect_v4"
>> > +
>> > +	which nc >/dev/null 2>&1 || return $ksft_skip
>> > +	nc --sctp -z 127.0.0.1 1 </dev/null 2>/dev/null || return $ksft_skip  
>> 
>> This can probably be instead::
>> 
>>   nc --help 2>&1 | grep -q -- --sctp || return $ksft_skip
>> 
>> This reads nicer to detect SCTP support in 'nc' binary.
>
> Can we use socat ? nc incompatibilities are hard to deal with.

Works for me

