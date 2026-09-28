Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72E4CDDF4
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602494; cv=none; b=epmD2nrF/1fdIuSqjOCPoMEnPL8pYZVhxgjeDBxTnppyUnwNW3PeTjYWL4XyPUqyU5CRYEooZjVRFRD8wfnasVLKIXQy35InnHyzjzbVPGMI00hCs+/1SO6geV3znFWoyb9BPK6HPEuxOp38Ijt3TuZc93CkDrr6FtAn3N66j40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602494; c=relaxed/simple;
	bh=T0ZnyZmNOhJs9F62i79irExNdtrq2m1MmyPDQyS/l2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UlmgyLCTzpF7OVHTEzYHCk4XYjHjs18+QnF+WwXWHPiTdJozlX+lJrxYgHzDxA4hRmiAcrlNFzd8cgAclf6q5lyLdElzwTnKKExnxNJldo6xo2k1ospcQiLeh9dvIiz3V147L3gJZEdHa/WtEVnqBNXxFVnM37FisqiLd7IZnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXPwNlmG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwKEOK4J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXPwNlmG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwKEOK4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790602489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T0ZnyZmNOhJs9F62i79irExNdtrq2m1MmyPDQyS/l2I=;
	b=ZXPwNlmGkQ/lC0N1sAPiWEN57qtRYgB5iWDecQ+MeoXBxigM/LCCUmHU1jVnpjcor4ZQ6y
	+Uy4tLfQmApAf8AVkYM9LtDpo7A1mWPnjjO8er5Q1QmqcRQeX1gJZjwg+iFeMQlL9dYtiK
	z3NQFvu/E04q7uA8bnZTLNu2H8Quyjg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-GAf4dLHTM9yub_OD1l-M0w-1; Mon, 28 Sep 2026 09:34:48 -0400
X-MC-Unique: GAf4dLHTM9yub_OD1l-M0w-1
X-Mimecast-MFC-AGG-ID: GAf4dLHTM9yub_OD1l-M0w_1790602487
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e6b5c5f44so47398715e9.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790602487; x=1791207287; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T0ZnyZmNOhJs9F62i79irExNdtrq2m1MmyPDQyS/l2I=;
        b=XwKEOK4J3S9W0Cpx8hG0f3eacL1Bupaqhf3WcLXDY9+tvkxDD8gCBMd+ucQ4qPhSiw
         so4SpHvQBQXtNstM5K5KSb5R50EnMc9I/S6KThvtHLAUpegcNgC+04Cc9L2SpreaFSPV
         zmiTmj2g/wRzfJ0X9qQWQY2GTyDv6Yk50QnT8IjLKrKxMTrwO1iuho5YeMWogCLvLRhg
         1YUNOA3Hu4DAosa4hoJfzZc4nnCc6itGjYzPnHYOUjVooGDufElVhtubVqxCFc8ZLnsl
         v++I8tsAFEwt4gczDS1S+ZdwfKxJOBixQhyXm2/6ieVNEkeWxRpP+YtJv9uDf5n3qeXg
         hSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602487; x=1791207287;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=T0ZnyZmNOhJs9F62i79irExNdtrq2m1MmyPDQyS/l2I=;
        b=2cVxYaweC1+EJr0LqAhW+EMrio0RQgoZXPphDTwJt9XLViC/qL3uO2l1ylqv3lfyFh
         ZafgDLEVSMLFfp+1wTR611JclykYBPdg3lPXfK738IaUIGN9HF+XMRqZhpqPEvKA/Bt8
         y4yW/FU+eGRmBuE34+fXUq4BB0rhMKJDVwI3jHeuhn/dIlprLoaEzHfLGJEw3DOdLa8V
         42hu//Qhb/Vy9Rhz68LojTaYrU4vx5jm/89Na966t1lr6LV30GBU9UYTiBUVHB46BUHr
         HItejju9643lDECw6rDglgce4OklJV0L6SbASQHtHxD1ZHBeJnsXfYQ20npIT1izMurd
         J0Cw==
X-Forwarded-Encrypted: i=1; AKwUvBxEnriMqDDdaYSEAIyAaKQ9+LylfwHFjKiAZzUX/UEJwq2zTsvmXlJHl1/yXfqQ5Q5+xPki4/k=@vger.kernel.org
X-Gm-Message-State: AFuF++lkPj8NbzOLAl9YnOqh1pxxPtLo6++BKmrLx4tBwM2PJFr2uurF
	7NbOBoY/UtFuxeDmLplfyoCncYiTDSabGKEYJq5k56iCjVWot1XAnJ0gknA81g+n0yI44Y0KwY0
	aoKq3qj14mwV6BnbVOw9b/Sf4znGPMAHIJKjMXdNdfdY1ge24xRBwzqeeLQ==
X-Gm-Gg: AYBFou1nkMb7IIgUcxhGGdA5KotmKZKFORlNNk33XbMzJdC5x1sSo5tXX0tl33BFphw
	UK47bJSyjcqXM9mf947xt5WEE8GZTUtF+4oLSMcks33P48pVrW6+sDfuMF11K1Cjna4juo5Qtms
	5LSAgu4qRGmQPsktfwszYPf8qIS9zuuVlcYdSQan8HkAXobNmK7NALRk+rvEPJ7UYDTMMNRlFjF
	fNKKBn8AKWhIW2B/5xVFiTP+/R7q+G0FBY54iwJs8HIFkUSDSPDvJGMJ4ZHqwg4IpxVIL4wtVLS
	Swt2hix0P074MtkTo+D14FMm/FJx7fDmqLdLhLUJ47ZlHLY/zgDoHCHzv0VXo2hIsyi6zvlQa3I
	/8aAaoAuxhSGkrcQU2/SFKWW994agwgQ=
X-Received: by 2002:a05:600c:348a:b0:49d:1840:4fd2 with SMTP id 5b1f17b1804b1-49fe7bbaf83mr214992515e9.23.1790602486810;
        Mon, 28 Sep 2026 06:34:46 -0700 (PDT)
X-Received: by 2002:a05:600c:348a:b0:49d:1840:4fd2 with SMTP id 5b1f17b1804b1-49fe7bbaf83mr214992045e9.23.1790602486412;
        Mon, 28 Sep 2026 06:34:46 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([24.151.142.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001906c5esm144276535e9.12.2026.09.28.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:34:45 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-trace-kernel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  Steven Rostedt <rostedt@goodmis.org>,  Masami
 Hiramatsu <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Ilya Maximets <i.maximets@ovn.org>,
  Matthieu Baerts <matttbe@kernel.org>,  Eelco Chaudron
 <echaudro@redhat.com>,  dev@openvswitch.org,  Adrian Moreno
 <amorenoz@redhat.com>,  Antoine Tenart <atenart@kernel.org>,  Johannes
 Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v7 3/4] net: dropreason: use new __print_sym() in tracing
In-Reply-To: <20260922110955.363677-9-johannes@sipsolutions.net> (Johannes
	Berg's message of "Tue, 22 Sep 2026 13:08:42 +0200")
References: <20260922110955.363677-6-johannes@sipsolutions.net>
	<20260922110955.363677-9-johannes@sipsolutions.net>
Date: Mon, 28 Sep 2026 09:34:39 -0400
Message-ID: <f7t1pad8pow.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> The __print_symbolic() could only ever print the core
> drop reasons, since that's the way the infrastructure
> works. Now that we have __print_sym() with all the
> advantages mentioned in that commit, convert to that
> and get all the drop reasons from all subsystems. As
> we already have a list of them, that's really easy.
>
> This is a little bit of .text (~100 bytes in my build)
> and saves a lot of .data (~17k).
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v7: update the selftest accordingly

Sorry for the late reply - this series was caught in a Spam filter for
some reason.

> ---

[ ... ]

> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index a31f7fb6882d..9b8edfcd2d1a 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -234,7 +234,7 @@ ovs_drop_reason_count()

For the OVS part (also nice to see the line count reduction) -

Reviewed-by: Aaron Conole <aconole@redhat.com>

