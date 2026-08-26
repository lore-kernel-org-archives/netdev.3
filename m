Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1443C069
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759484; cv=pass; b=EwqHqCUfHHQZE/YZD72MzAA5e2DZl0ycXBIfIKd+c/d70sCblywqaE5UwVEeMKEcjZRdH3oZ2KGGBRsOD1BuYwNcPhyuzB+h7g+M93RaFLGa1egVR1RnJRmogICeuZ6rumYHV+dIZU11zl8DgSL3AR4TmAkRiB7Hm1JHOjkpjM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759484; c=relaxed/simple;
	bh=S3oedpMLe1X5Nm1NXewwS51diE6KsPbimGy753lm/k4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jgEUWPtCJJpHcDWpe07LeOuwPsfU+UjdwBLngjAepQRcprQoW0EYdnRsjCWHdPbXTys/f+zxCGuzQCfFQn5NDjD+topjqcrOd15SEGXVKDh1hqOLf4fkhPKOW3PvQeHubMmR8U8z7kc4q5w3tOinTjHmLNa8jIUZAPqGQlhn5kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRIlCco9; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRIlCco9"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97c79f2db08so462351241.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 08:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787759475; cv=none;
        d=google.com; s=arc-20260327;
        b=pR8dEs8OKnTlJ93lwVY/DBBGHI7B4cC3k5rR1sQ2+RFJWsPT+hNgY24agqSn+XBUjz
         tifRrC/wuqvIEigK06ywKjzu7NUU1QYwdIsdg+xo2RGUJKuKCaV0KVBjJXue3IGU39bg
         4ykkoQxpw/Bot9cuLRMBb/9xZenkBuOKWQLVfZhSeD6A33gfK8iC7pZLQmnZ7jIIPS6b
         L/SBfWZt8UZcAapD2TBuwjlbpWPCgls0SphR85gUorYchsPjze+Txd1F5tO02EWp6qfI
         3uNxoNuvFw2yaG+eTcuUWFIUo7zopn/C9fIhWnMmK5WLpggD9tJqr1UGfA7L5tk2eT02
         d7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SNQiDCMuOX4DVQkBqaZPrnMLK28Qu1U9AZkg+Khh1qI=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=kf+3InwBkgqy6atGQKlpwQuDD5tWnPMchaWq2Bw4zxTG4iIc1/Fcmcf4c9D9M6N8Nn
         KjS+obTeboNCgzfHJwyAw00+jKtzPsjEV4UbezWXliNY8997hnhgmcVfLLm/nbBoIhSx
         KdjdoaDZ0KlxqqcIb6c1Vfp1diBywuPuYI+DGlVR58lEbSfVGKLe8LRjTmigS+nU7k5A
         324Cszs9h+TbasNC2z9L7kj6iOyzvYKSgdcOg5Ow8H0bJTX8gS4zHDwR5yjFL4XkoSS+
         9sVAsLWDJh1YzoVyaVwl/ITXYdWoyUAeqS1N1SEcw52zfq/PrAHZEyxY+Ktzidht5R9X
         Yo7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787759475; x=1788364275; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SNQiDCMuOX4DVQkBqaZPrnMLK28Qu1U9AZkg+Khh1qI=;
        b=NRIlCco9vqwI4f8I65bd+/jEJm48LUxLcnvP1Z96vJKD7SwWBZx4QhheeBxERDejwq
         64IDZsPfKx3HRiChVPuI973ob625UjMMAlrLwhIsjhYLOuMvONr7FpVfXPj/BgcqE9Ph
         N/4VlvcdnLjppHgf+TWZxlgQtteu14+d1dnBZkDnvJtmP0dEN1xVW9LFeS4XzJX1DzDE
         DNzkoprnx4HkDjn7pVVNaO052X44Al6hj4Le31uzidb150ogXOM1xDzVTrY+9Nz69+KM
         udIWz/JG2WX/tTngw8YnPXWaS52gziCrrwWLOmEY5fFkm7DXDQFyAEbI5GmO5jjasad5
         b5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759475; x=1788364275;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SNQiDCMuOX4DVQkBqaZPrnMLK28Qu1U9AZkg+Khh1qI=;
        b=kFMLvC4+wU9hDh806pbNGzsSxyuI4jToEecFKohXATkPlpWLVG8IK+fojg+hvMvdV9
         4IlwvxvIn4KGK4Fw1NjxAGTfCoklSTwp1x/+/J1pr4Oyp4eUGq/FpnhwAHHSWG9vPLu0
         M9Hlnvlc9N5MIJ7ifLZWXlBuAadDEasB7zDjShagtQNv28AnL4FL6ec6krNTpD99LuGZ
         gbNkVDcXF7MbbmWeT/toa5KplDnuisuIIr1QYgmaesizdCJeyDh46KCQQpCnixlg/aUY
         zPBaMSi+wj5k0skvARJrLLdiGt/qoBK3NoZGYgT5tbgoOgs3l/5+3Y1klBy0bdtF3mBY
         oKBA==
X-Gm-Message-State: AFuF++kLGD2kPsHlma+k9eW4TuQDUZIe0O1GrY3bBvqmT/YBUSSc+33P
	m401A+Xcj3p0FmO5by5k21gheVLHy1vkowV4TidYWBKggoHFktSZ8QZsgkOC3DcJ3ox9CTfPWZE
	XYJdJmQ1BhbBhow2VVXULppvxktSjifzoLRKwuqOrhQ==
X-Gm-Gg: AR+sD13EJN/8aNXi6SC4xAtmTkg5VHjdgs+nMZRNBh0SghM4on0Z1s5OZzZ94MPeQHX
	tnXvpZTBHQE4/LKmIcfZxkQ3dWr3aGCRQWs5vIIq9cgIiE3BJNK6T1JOgAvZR+5mpVKx8vpb+Ww
	TbP2m246kP/GS5K07AX67jYllCVOIENTsoUU+l1GP5TKf3H0ND/iAbkW9T0yIIf5yeJkjWv0u/U
	Oa+dzPaEP9FXY+/yCbQ/L+hP5GFRDjY3TPH1zXeWEJ9/Wp7x95GiMC/lGERhr5F01dhmYNRZhxi
	Hb/hgrZyrj0W4vs1Pr9edEq4LzNVJEdmKjXaJhgDZSKg74p4ukkEjQOIow==
X-Received: by 2002:a05:6102:1628:b0:74c:7fd8:73f5 with SMTP id
 ada2fe7eead31-782c07ff7a7mr3060132137.6.1787759474891; Wed, 26 Aug 2026
 08:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: AnnaIv <ivanutka19@gmail.com>
Date: Wed, 26 Aug 2026 18:51:17 +0300
X-Gm-Features: AcwNN1XaKNFbDSqdoop8gk09iC_dKf5EWlR0g8BvA8unZZK7aCcgTQMzlWSQIr0
Message-ID: <CAL+YWWAg6ptwpvaJ5KynbSdOarFZPBHtXp+fLMPuq5uk_Lp_ZQ@mail.gmail.com>
Subject: iproute2 parser vor ip6gre interface configuration
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I noticed something that can be considered as a bug and not a
vulnerability. When I try to up interface with this line in
configuration file:

pre-up ip tunnel add mgre0 mode ip6gre key 1 ttl 64 tos inherit/c0

it cannot be parsed as it is already parsed in ipv4 gre tunnel. I
checked file link_gre6.c function gre_parse_opt. It says that
parameter inherit/number cannot be parsed as two. On page
https://man7.org/linux/man-pages/man8/ip-tunnel.8.html there is a
paragraph:

tclass T
                     set the type of service (IPv4) or traffic class
                     (IPv6) field on tunneled packets, which can be
                     specified as either a two-digit hex value (e.g. c0)
                     or a predefined string (e.g. internet).  The value
                     inherit causes the field to be copied from the
                     original IP header. The values inherit/STRING or
                     inherit/00..ff will set the field to STRING or
                     00..ff when tunneling non-IP packets. The default
                     value is 00.

I consider this as statement that for IPv4 and IPv6 it must be parsed
identically. Please, could you fix this issue?

I know that in Linux ip6_gre.c function prepare_ip6gre_xmit_other for,
as I think, sending non-ip parameter flags has higher priority than
flowinfo. It can be considered as a reason not to change parser. But I
think that it also can be fixed with a small patch. I will suggest
this patch to Linux project or at least fix it just for me.

In any case I ask you to consider this issue because it contradicts
the paragraph from linux man-pages.

I suppose that without patch you don't accept my issue so I decided to
make it by myself
Replace:
 else if (!matches(*argv, "tos") ||
               !matches(*argv, "tclass") ||
               !matches(*argv, "dsfield")) {
            __u8 uval;

            NEXT_ARG();
            flowinfo &= ~IP6_FLOWINFO_TCLASS;
            if (strcmp(*argv, "inherit") == 0)
                flags |= IP6_TNL_F_USE_ORIG_TCLASS;
            else {
                if (get_u8(&uval, *argv, 16))
                    invarg("invalid TClass", *argv);
                flowinfo |= htonl((__u32)uval << 20) & IP6_FLOWINFO_TCLASS;
                flags &= ~IP6_TNL_F_USE_ORIG_TCLASS;
            }
        }
With:
else if (!matches(*argv, "tos") ||
               !matches(*argv, "tclass") ||
               !matches(*argv, "dsfield")) {
            static const char inherit_str[] = "inherit";
            const size_t inherit_len = sizeof(inherit_str) - 1;
            __u8 uval;

            NEXT_ARG();

            flowinfo &= ~IP6_FLOWINFO_TCLASS;

            if (strncmp(*argv, inherit_str, inherit_len) == 0 &&
                (*argv)[inherit_len] == '/') {
                char *val = *argv + inherit_len + 1;

                if (get_u8(&uval, val, 16))
                    invarg("invalid TClass", *argv);

                flowinfo |= htonl((__u32)uval << 20) & IP6_FLOWINFO_TCLASS;
                flags |= IP6_TNL_F_USE_ORIG_TCLASS;
            } else if (strcmp(*argv, inherit_str) == 0) {
                flags |= IP6_TNL_F_USE_ORIG_TCLASS;
            } else {
                if (get_u8(&uval, *argv, 16))
                    invarg("invalid TClass", *argv);

                flowinfo |= htonl((__u32)uval << 20) & IP6_FLOWINFO_TCLASS;
                flags &= ~IP6_TNL_F_USE_ORIG_TCLASS;
            }
        }

so it can parse inherit/number type of argument. Please, consider my fix

Sincerely, Anna
