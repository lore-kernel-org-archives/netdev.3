Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703416;
	b=ZQDPBi0vMH97CmIICv/d1fTvSy/IAM8FiZJb3vhhF0+t4sHucTTTImFiLzgIQWDrlOeZ
	 n9P0HqddioskzdJxMmuBpPc75iNH8zu5PC3DJ3cCl6x+EfZKjBBnECEH1Wb5QXCrbO3ME
	 FQl62D/tPvcA/QEXtngH8bcMijMg6tILP/PgOvVLir+zANGk74VzLqEuW/5PGGRDEI4g1
	 4Nrw6+n7zUlpDxmKv100Mqsd1BNQ1Zs8BErdUY8D7MLYooUfNVE0lmsL6G85grbDcBjZ9
	 nq6HwReh7cu7dG/1AeEWx0MiFo9cJzzV63hi6jZRZxr3UHA4rmbS/8D5LwmMKdUOn2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703416;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rS/e46e9OMfoCd5XFurOSEsLGxilXv14jNpZGdh48YU=;
	b=dQq/RLaWBX+DT7iVlAWHVsYmp3OttHaZza5dddyeHaSYEZ/5113/MGxomrD4ckvjy7BG
	 6peB+JppUZCEteBfnMG7oBHOOl7K50zqc0q4zr1yobzuRWJlmMg8tlrQ0FgUnh53pdjsp
	 VDY5KwEdcaoqatQ/1bLkAmaQ0NQ7GIDYTPcC6uZa0jwwA/bA6qNS9wR1HoPO0N0NWgXXs
	 8lV1OvR3djSbKD2drWFmbsp5kHhnv7Hws6aYFM9G77QGywhPL6WB0yS719eLasxX4os2U
	 0/183xoIjP9MGf5yP84vMOKNQoK+f3t0OI/UNU4Ah89W6fzc4bcnUZmrYzhROUjWyDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=gfCcyjhK;
	arc=none smtp.remote-ip=79.135.106.98
Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5E606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 21:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23F5E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=gfCcyjhK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1792703413; x=1792962613;
	bh=rS/e46e9OMfoCd5XFurOSEsLGxilXv14jNpZGdh48YU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gfCcyjhKN+AtHlGjzxjnANy/JO2tNabMM8m+3U6D1T2RggBdjaSjGDGI2Yr94yzup
	 V2ZFIYsw4LIm2THpvFP8rkskibhW51mGVe+AdaG0rMYPXszdXvL5bQzRAUMuJ+fa78
	 hjeCcVkEznzxd/mTpWILDf8IEV7phw7PJL0WgSDs+e0c+lPiWFH8FlHT7dEXYP00XW
	 VlJYfLwlInOLOEZwF0sqmOnT2HKYbHTjxdN2J9sM70IuhpoKauB+AoA7uRfvjYBrNh
	 BTXvOrlpyBmMiAA5f5FQ/Sc87uyevJnbFnxbfH1Z2Gzyau4l3PjVQZF/wyezyap5Kf
	 MFB5FdqLxrEug==
Date: Thu, 22 Oct 2026 21:10:07 +0000
To: netdev@vger.kernel.org
From: Hadrien Patte <hadrien.patte@protonmail.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Hadrien Patte <hadrien.patte@protonmail.com>
Subject: [PATCH iproute2-next] json_writer: fix pretty printing of arrays
Message-ID: <20261022211002.31098-1-hadrien.patte@protonmail.com>
Feedback-ID: 2516487:user:proton
X-Pm-Message-ID: 47e445c17020e0f008494dcbf1bc24e2db4376e5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When pretty printing, array elements were emitted on a single line and
the closing bracket of an array of objects was glued to the last
element, producing hard to read output such as:

[ {
        "ifindex": 1,
        "flags": [ "UP","LOWER_UP" ]
    },{
        ...
    } ]

Move newline handling into jsonw_eor() so every element of an array or
object starts on its own indented line, and let jsonw_end() emit the
newline before the closing bracket for arrays as it already does for
objects. A property name now sets sep to ':' so the following value is
not separated from its name.

Output now looks like:

[
    {
        "ifindex": 1,
        "flags": [
            "UP",
            "LOWER_UP"
        ]
    },
    {
        ...
    }
]

Empty arrays are now printed as "[]" instead of "[ ]", matching empty
objects. Non-pretty output is unchanged.

Signed-off-by: Hadrien Patte <hadrien.patte@protonmail.com>
---
 lib/json_writer.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/json_writer.c b/lib/json_writer.c
index d4a1c72b..d5ff8d8b 100644
--- a/lib/json_writer.c
+++ b/lib/json_writer.c
@@ -22,7 +22,7 @@ struct json_writer {
 =09FILE=09=09*out;=09/* output file */
 =09unsigned=09depth;  /* nesting */
 =09bool=09=09pretty; /* optional whitepace */
-=09char=09=09sep;=09/* either nul or comma */
+=09char=09=09sep;=09/* nul, comma, or colon after name */
 };

 /* indentation for pretty print */
@@ -46,8 +46,20 @@ static void jsonw_eol(json_writer_t *self)
 /* If current object is not empty print a comma */
 static void jsonw_eor(json_writer_t *self)
 {
-=09if (self->sep !=3D '\0')
-=09=09putc(self->sep, self->out);
+=09switch (self->sep) {
+=09case ',':
+=09=09putc(',', self->out);
+=09=09jsonw_eol(self);
+=09=09break;
+=09case ':':
+=09=09/* after property name, don't output comma or newline */
+=09=09break;
+=09case '\0':
+=09=09/* first element of a container, not start of document */
+=09=09if (self->depth)
+=09=09=09jsonw_eol(self);
+=09=09break;
+=09}
 =09self->sep =3D ',';
 }

@@ -143,9 +155,8 @@ static void jsonw_end(json_writer_t *self, int c)
 /* Add a JSON property name */
 void jsonw_name(json_writer_t *self, const char *name)
 {
-=09jsonw_eor(self);
-=09jsonw_eol(self);
-=09self->sep =3D '\0';
+=09jsonw_eor(self);
+=09self->sep =3D ':';
 =09jsonw_puts(self, name);
 =09putc(':', self->out);
 =09if (self->pretty)
@@ -177,15 +188,10 @@ void jsonw_end_object(json_writer_t *self)
 void jsonw_start_array(json_writer_t *self)
 {
 =09jsonw_begin(self, '[');
-=09if (self->pretty)
-=09=09putc(' ', self->out);
 }

 void jsonw_end_array(json_writer_t *self)
 {
-=09if (self->pretty && self->sep)
-=09=09putc(' ', self->out);
-=09self->sep =3D '\0';
 =09jsonw_end(self, ']');
 }

--
2.56.0



