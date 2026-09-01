Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2536826B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272343; cv=none; b=urhOqq9IkWFLbiJwso0W2F6FhQAeb0nBCtTTyDTC3yiR34Wai5ZUxcLUahvNKfXxMWdBszeGtfTkhaui+pDRG1mpXQYacmbunIlcMa8Gd8zuhjXUw8uNMcdQV+jGfX4qGhISe4Ugr3uns1jujVLKt9U5lX2YuhmDpaLTXaLWrE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272343; c=relaxed/simple;
	bh=NkKu/8w/1z6LkfAgeZyRMbEQJIQaUAmSCXu3cnPAVn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS19iIyb7lxwBjSFt9Pfd3V8lsOaCKVO+23u4XCyng8p1k6+dAKGguZdh/XHy2d+nZtWr5Hmlbz4vAHX8puEqEdcPfLOMhdTK8sJ0aDOt1F0s+G0TqVh7aGFb530WePkAJxNZTwp+/83eyqiQXXv11y78W3NgJyEwC2PU688Nk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=doWzLE0m; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="doWzLE0m"
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C6AA53F82D
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788272338;
	bh=rEDcPAogTZg6PX5XCNiS3w5Hhl82tH+An2kp4bmc7So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=doWzLE0mx26Ni5FeXoni/pIL6G4Lmm9b+8gRmirw0iZkcb61mv+ETjHzhU8pXhCzz
	 /pslh5BMoffe7taubcGT76yv6iaMvrbzbt+YKunG/9r8Pp2enI2T/7KKyb4aE0rzn4
	 7zw4X8jCfTMXf05IrVXF+6rY54LMIVG/I5PVpac0t0utqZZWBpBj578T/JOTG0hrEX
	 GBzw+N/bSj4wme+NQHgPWBBhDwP++jFhCV8j5K7TtSDOw2RUAPm652lpXQmizYTRYR
	 hRQqxpbYiQ4lESZZa/VxY5jWnmhrje7KHv6M5FB3IUYAT36TLMbYa+5soGn+QeBCW8
	 hnoVrOQlu3vQmlbHT70GI1ABu9hKDA1Ln09Bbvwseto4aeKJypJmy/BC3hCVQJxyyz
	 uu5dbY6bfCFtXrqbkX2g8LUlg0rZVjof/3lSrkEyuIqLVTcj4mzkxkNP+LCAyKJTLf
	 vIvka4bJQTiL0aZiaxT1ZxYuO7mt02qVxvrtOlc64W/Uu5za3JPuoOjVsu/M27ovXg
	 /lLxWRDTdviq3R2/42IHJq8WKePAlVFZk88eHeLOQ4C1I5M3Bl7Mn71jAMB504gKLP
	 5ljuvpx681QdcKLpRGuJEfiiFNcveOjp+Q3cAKuomU2GOm5PKWYtosCv/GajT9Jh/e
	 L3eUPagE9QyJpQSX8gO1h0tQ=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482f4a554dcso936719f8f.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 07:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272338; x=1788877138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEDcPAogTZg6PX5XCNiS3w5Hhl82tH+An2kp4bmc7So=;
        b=Kz9tHx35vz2Qodb64bj5iVoEIk8isPSebf9w6w9T39rKwkaJqLu67oiBv8aUO7dw5g
         GU5j5V2foNi4VqOMGC8qyBoOSi5+p3T+agRkbWy8jSwX9pwpwBe31y/D5fcVmX7fFeDi
         Y2luIyHconVCwY5uzZ3B/xO79F6RaM34z/folwGaJc614SJuxupnBfqNKt6SM6SHaq+r
         LEfc+tXs5fxUmKicA+eoHI1oUeSj6N5UhVXxrD+cZPNXOpHIYVExjNx0NeZ/PjDu+Xfc
         3HjbsB+pZ3Ue9HnF+tdWQsr3Jit1UgT8OVCgmxtwkRyW2/2Tv4XqHNHzp8f+Ysgx+YR4
         Ab5w==
X-Forwarded-Encrypted: i=1; AHgh+Rod4yr4jLxP3bYI5zwBySWpvhjotQVK/tB9jWmluRvVMFmXwLyTLAQBp3/QZE/yl0e785GqP/o=@vger.kernel.org
X-Gm-Message-State: AFuF++kjjmr4TgkwHYkK9iH7PlYBrDki3MRb2f4sP5veLMoWLyTwBHUR
	9PXkYd8ebjev2JSaQat74b51jSc6vqyC7NJEhNQk7yB+K8HT2PSYgn+5Z6II5HsVS5O4ErGW7en
	dEreXPfmKp5xifuDr1aKpJloNlGxoL0vYjmz/z7Uc/E8cZojPSfD2hyolR+KYZHlH2hJZnKMWXT
	Ke7KYWZQ==
X-Gm-Gg: AR+sD11xPUJ7OYR9ESt3irOqbhOqIYiHATRQMuH7jg1pJSg9TgeSdsqGsU3syGccAA8
	+RcS19PjNfPhxITJV2A0xVZEPsDZS1AG5jRTuugSreT2pdqEceK4OrmdRZNwqCkn6kTwGEaHEiv
	7Q6B6rrIFUDpot4jWaf0DrPrz0QaZmkNztjYYZzCHjKnvaHlGEU52Zk2c/Y0dIGR983DoP0+cm2
	P5VDp+Jy8p1eXDtIExEbUZFABs+e6WrpmNO+GDjVamO5bDe2lZcUWz2Mo8zUnBYQUU+HLZ+Dc8P
	yyI2IXdgUNR63RUG39oimVKs9sM0uNzDzB2nVtYJEWW3+ZXwB8DBS2SQ6g12cVyTzOsJ8xqHnW2
	MmjIljBHoq/+gK2zV825xSyEfaGUhiWDWAT3T5uGlIKETNnUceshBH6QamIIdx3BWXyJjacek
X-Received: by 2002:a05:600c:4e01:b0:49c:cedc:768a with SMTP id 5b1f17b1804b1-49ccedc76a1mr483018545e9.16.1788272338224;
        Tue, 01 Sep 2026 07:18:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e01:b0:49c:cedc:768a with SMTP id 5b1f17b1804b1-49ccedc76a1mr483017535e9.16.1788272337856;
        Tue, 01 Sep 2026 07:18:57 -0700 (PDT)
Received: from localhost (93-35-116-250.ip54.fastwebnet.it. [93.35.116.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1025asm69057965e9.6.2026.09.01.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:18:57 -0700 (PDT)
Date: Tue, 1 Sep 2026 16:18:56 +0200
From: Alessio Faina <alessio.faina@canonical.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, hangbin.liu@linux.dev,
	stefano.salsano@uniroma2.it
Subject: Re: [PATCH net] selftest/net: skip srv6_end_d[t/x][4/6]_*_test.sh if
 iproute2 too old
Message-ID: <apbe0PAvaes977l-@cicciput>
References: <20260824091537.2305107-1-alessio.faina@canonical.com>
 <20260826000156.bdaa71db68dbdc9c13907205@uniroma2.it>
 <ao7S04LkWVXAQpgq@cicciput>
 <20260827030701.bfaf6eea6dea1aef24c353cf@uniroma2.it>
 <apAJuZzDOvjkVx60@cicciput>
 <20260828042357.1d6e802448752a8fdff5a485@uniroma2.it>
 <apGxmfjQs247lHX-@cicciput>
 <20260829231150.8180c09f6874606eb49d0243@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829231150.8180c09f6874606eb49d0243@uniroma2.it>

On Sat, Aug 29, 2026 at 11:11:50PM +0200, Andrea Mayer wrote:
> On Fri, 28 Aug 2026 18:04:41 +0200
> Alessio Faina <alessio.faina@canonical.com> wrote:
> 
> > [snip]
> > 
> 
> Hi Alessio,
> 
> > I tried multiple methods:
> > the first approach is yours, but I can see the following error with any iproute2 
> > version I'm using (I tried 5.5 to 5.18): when running 
> > "ip -netns ${rtdst_name}" command, it always returns 
> > 
> > RTNETLINK answers: File exists
> > 2
> 
> EEXIST means that the object is already there, and says nothing about
> vrftable. When ip does not know vrftable it refuses the command itself,
> with the error you showed earlier: either "to" is duplicate,
> or "vrftable" is a garbage.
> 
> In a netns created by the check there is nothing to collide with, so EEXIST
> does not come from the way I suggested. The full command and output would
> settle it.
> 
> > I tried the following approach as well,
> > 
> >  	# set the decap route for decapsulating packets which arrive from
> >  	# the rtdst router and destined to the hsdst host.
> > -	ip -netns ${rtdst_name} -6 route add ${vpn_sid}/128 table ${LOCALSID_TABLE_ID} \
> > -		encap seg6local action End.DT4 vrftable ${tid} dev vrf-${tid}
> > +	if ! ip -netns ${rtdst_name} -6 route add ${vpn_sid}/128 table ${LOCALSID_TABLE_ID} \
> > +			encap seg6local action End.DT4 vrftable ${tid} dev vrf-${tid} 2>/dev/null; then
> > +		echo "SKIP: SRv6 End.DT4 vrftable not supported in iproute2"
> > +		cleanup
> > +		exit "${ksft_skip}"
> > +	fi
> > 
> > where the test is checked at vrftable creation time, and it would
> > cleanup and exit as expected from standard tests.
> > 
> > But obviously this gets the same RTNETLINK answer as an error.
> > 
> 
> This is a setup step, not a check. The skip decision is taken while the
> topology is being built, because setup_vpn_config() is called several times
> inside setup(). The check should run before setup(), once.
> 
> The way I suggested runs the route add with vrftable in a throwaway netns,
> created and removed by the check itself.
> test_encap_lookup_supp_or_ksft_skip() in srv6_encap_lookup_l3vpn_test.sh
> has that shape: it creates the netns, adds the device it needs, tries its
> route, and on failure cleans up and exits ksft_skip. For the dt4 and dt6
> tests that device is a vrf bound to the table passed to vrftable, and the
> netns also needs the strict mode.
> 
> > Then another approach came to my mind, and it seems to be quite reliable.
> > Practically checking if the ip command contains the string "vrftable"
> > using the "strings" command, and if not, skip the test.
> > 
> > Something like this:
> > 
> > +test_iproute2_vrftable_supp_or_ksft_skip()
> > +{
> > +	if ! strings $(command -v ip) | grep -q "vrftable"; then
> > +		echo "SKIP: SRv6 End.DT4 vrftable not supported in iproute2"
> > +		exit "${ksft_skip}"
> > +	fi
> > +}
> > +
> > 
> > What do you think about it?
> 
> I would rather not add a new tool dependency to these two tests. The
> route add uses ip, which the test needs anyway.
> 
> Ciao,
> Andrea

Hi Andrea,

I understand, what you say makes sense; in the end what you originally
suggested seems to be the best approach.

I tried this

+test_iproute2_vrftable_supp_or_ksft_skip()
+{
+	ip netns add __vrftable_test 2>/dev/null
+	ip netns exec __vrftable_test sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
+	ip -netns __vrftable_test link add vrf-100 type vrf table 100
+	ip -netns __vrftable_test link set vrf-100 up
+	if ! ip -netns __vrftable_test -6 route add fc00::1/128 \
+			encap seg6local action End.DT4 vrftable 100 dev vrf-100 2>/dev/null; then
+		ip netns del __vrftable_test 2>/dev/null
+		echo "SKIP: SRv6 vrftable not supported in iproute2"
+		exit "${ksft_skip}"
+	fi
+	ip netns del __vrftable_test 2>/dev/null
+}
+
+test_iproute2_vrftable_supp_or_ksft_skip
+

and seems to be behaving as expected in my environment for multiple
iproute2 versions. If you're happy with it I'll send a v2 to net-next.

Kind regards,

    -Alessio Faina
